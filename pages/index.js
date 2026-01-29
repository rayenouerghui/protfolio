import Base from "@layouts/Baseof";
import ImageFallback from "@layouts/components/ImageFallback";
import { getListPage } from "@lib/contentParser";
import { markdownify } from "@lib/utils/textConverter";
import Link from "next/link";
import { useState } from "react";

const Home = ({
  banner,
  projects,
  experiences,
  certifications,
}) => {
  const [selectedProject, setSelectedProject] = useState(null);

  return (
    <Base>

      {/* Enhanced Professional Banner */}
      <section className="relative min-h-[80vh] flex items-center justify-center overflow-hidden bg-gradient-to-br from-slate-50 via-blue-50 to-indigo-100 dark:from-slate-900 dark:via-slate-800 dark:to-slate-900">
        {/* Animated Background Elements */}
        <div className="absolute inset-0 overflow-hidden">
          <div className="absolute -top-40 -right-40 w-80 h-80 bg-primary/10 rounded-full blur-3xl animate-pulse"></div>
          <div className="absolute -bottom-40 -left-40 w-80 h-80 bg-blue-500/10 rounded-full blur-3xl animate-pulse delay-1000"></div>
          <div className="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-96 h-96 bg-indigo-500/5 rounded-full blur-3xl animate-pulse delay-500"></div>
        </div>
        
        {/* Grid Pattern Overlay */}
        <div className="absolute inset-0 opacity-30">
          <div className="absolute inset-0 bg-gradient-to-br from-transparent via-primary/5 to-transparent"></div>
        </div>

        <div className="container relative z-10">
          <div className="row items-center justify-center min-h-[60vh]">
            <div className={banner.image_enable ? "text-center lg:text-left lg:col-6 animate-slide-up" : "text-center lg:col-8 animate-slide-up"}>
              <div className="banner-title mb-8">
                <div className="inline-block">
                  {markdownify(banner.title, "h1", "text-4xl md:text-5xl lg:text-6xl font-bold leading-tight mb-4 bg-gradient-to-r from-slate-900 via-primary to-blue-600 dark:from-white dark:via-blue-400 dark:to-blue-300 bg-clip-text text-transparent")}
                  {markdownify(banner.title_small, "span", "block text-xl md:text-2xl font-medium text-slate-600 dark:text-slate-300 mt-2")}
                </div>
              </div>
              <div className="prose prose-lg max-w-none mb-8">
                {markdownify(banner.content, "p", "text-lg md:text-xl leading-relaxed text-slate-700 dark:text-slate-300 max-w-2xl mx-auto lg:mx-0")}
              </div>
              {banner.button.enable && (
                <div className="flex flex-col sm:flex-row gap-4 justify-center lg:justify-start">
                  <Link
                    className="btn btn-primary btn-lg group relative overflow-hidden"
                    href={banner.button.link}
                    rel={banner.button.rel}
                  >
                    <span className="relative z-10 flex items-center justify-center">
                      {banner.button.label}
                      <svg className="ml-2 w-5 h-5 transition-transform group-hover:translate-x-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 8l4 4m0 0l-4 4m4-4H3" />
                      </svg>
                    </span>
                  </Link>
                  <a
                    href="#projects"
                    className="btn btn-outline-primary btn-lg group"
                  >
                    <span className="flex items-center justify-center">
                      View Projects
                      <svg className="ml-2 w-5 h-5 transition-transform group-hover:translate-y-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 14l-7 7m0 0l-7-7m0 0l7-7" />
                      </svg>
                    </span>
                  </a>
                </div>
              )}
            </div>
            {banner.image_enable && (
              <div className="col-10 lg:col-6 mt-12 lg:mt-0 animate-scale-in">
                <div className="relative">
                  <div className="absolute inset-0 bg-gradient-to-r from-primary/20 to-blue-500/20 rounded-full blur-3xl transform scale-110"></div>
                  <ImageFallback
                    className="relative z-10 mx-auto object-contain drop-shadow-xl hover:scale-105 transition-transform duration-500"
                    src={banner.image}
                    width={548}
                    height={443}
                    priority={true}
                    alt="Banner Image"
                  />
                </div>
              </div>
            )}
          </div>
        </div>
      </section>

      {/* Home main */}
      <section className="section">
        <div className="container">
          <div className="row items-start">
            <div className="lg:col-12">
              {/* Enhanced Projects Section */}
              {projects?.enable && (
                <div className="py-20 bg-white dark:bg-slate-900" id="projects">
                  <div className="container">
                    <div className="text-center mb-16">
                      <h2 className="text-3xl md:text-4xl font-bold text-slate-900 dark:text-white mb-4">
                        Featured Projects
                      </h2>
                      <div className="w-24 h-1 bg-gradient-to-r from-primary to-blue-500 mx-auto mb-6"></div>
                      <p className="text-lg text-slate-600 dark:text-slate-300 max-w-2xl mx-auto">
                        Explore my latest work showcasing modern development practices and innovative solutions
                      </p>
                    </div>
                    
                    <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 max-w-7xl mx-auto">
                      {projects?.list?.map((project, index) => (
                        <div 
                          key={`project-${index}`}
                          className="group relative bg-white dark:bg-slate-800 rounded-xl shadow-lg hover:shadow-xl transition-all duration-500 overflow-hidden border border-slate-200 dark:border-slate-700 hover:border-primary/50 dark:hover:border-primary/50"
                        > 
                          {/* Project Image */}
                          {project.image && (
                            <div className="relative overflow-hidden">
                              {project.image.endsWith('.mp4') ? (
                                <video
                                  className="w-full h-64 object-cover transition-transform duration-500 group-hover:scale-105"
                                  autoPlay
                                  muted
                                  loop
                                  playsInline
                                >
                                  <source src={project.image} type="video/mp4" />
                                  Your browser does not support the video tag.
                                </video>
                              ) : (
                                <ImageFallback
                                  className="w-full h-64 object-cover transition-transform duration-500 group-hover:scale-105"
                                  src={project.image}
                                  alt={project.title}
                                  width={800}
                                  height={400}
                                />
                              )}
                              <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300">
                                <div className="absolute bottom-4 left-4 right-4">
                                  <button
                                    onClick={() => setSelectedProject(selectedProject === index ? null : index)}
                                    className="w-full bg-white/90 dark:bg-slate-800/90 backdrop-blur-sm text-slate-900 dark:text-white font-semibold py-2 px-4 rounded-lg hover:bg-white dark:hover:bg-slate-800 transition-all duration-200"
                                  >
                                    {selectedProject === index ? "Hide Details" : "View Details"}
                                  </button>
                                </div>
                              </div>
                            </div>
                          )}
                          
                          {/* Project Content */}
                          <div className="p-6">
                            <h3 className="text-xl font-bold text-slate-900 dark:text-white mb-3 group-hover:text-primary transition-colors">
                              {project.title}
                            </h3>
                            <p className="text-slate-600 dark:text-slate-300 leading-relaxed mb-6">
                              {project.description}
                            </p>
                            
                            {/* Languages - Always visible with enhanced design */}
                            {project.languages && (
                              <div className="mb-6">
                                <h4 className="text-sm font-semibold text-slate-900 dark:text-white mb-4 flex items-center">
                                  <svg className="w-4 h-4 mr-2 text-primary" fill="currentColor" viewBox="0 0 20 20">
                                    <path d="M13 6a3 3 0 11-6 0 3 3 0 016 0zM18 8a2 2 0 11-4 0 2 2 0 014 0zM14 15a4 4 0 00-8 0v3h8v-3z"/>
                                  </svg>
                                  Tech Stack
                                </h4>
                                <div className="grid grid-cols-1 gap-3">
                                  {project.languages.map((lang, i) => (
                                    <div key={`lang-${index}-${i}`} className="flex items-center space-x-3">
                                      <div className="flex items-center space-x-2 min-w-[120px]">
                                        <i className={`devicon-${lang.icon}-plain text-xl`} style={{ color: lang.color }}></i>
                                        <span className="text-sm font-medium text-slate-700 dark:text-slate-300">{lang.name}</span>
                                      </div>
                                      <div className="flex-1 flex items-center space-x-3">
                                        <div className="flex-1 bg-slate-200 dark:bg-slate-700 rounded-full h-2 overflow-hidden">
                                          <div 
                                            className="h-full rounded-full transition-all duration-1000 ease-out"
                                            style={{ 
                                              width: `${lang.percentage}%`,
                                              backgroundColor: lang.color,
                                              boxShadow: `0 0 10px ${lang.color}40`
                                            }}
                                          ></div>
                                        </div>
                                        <span className="text-xs font-semibold text-slate-600 dark:text-slate-400 min-w-[40px] text-right">
                                          {lang.percentage}%
                                        </span>
                                      </div>
                                    </div>
                                  ))}
                                </div>
                              </div>
                            )}

                            {/* Expandable Details */}
                            {selectedProject === index && (
                              <div className="mb-6 space-y-4 animate-fade-in border-t border-slate-200 dark:border-slate-700 pt-6">
                                {project.features && (
                                  <div>
                                    <h4 className="text-sm font-semibold text-slate-900 dark:text-white mb-3 flex items-center">
                                      <svg className="w-4 h-4 mr-2 text-primary" fill="currentColor" viewBox="0 0 20 20">
                                        <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd"/>
                                      </svg>
                                      Key Features
                                    </h4>
                                    <div className="grid grid-cols-1 md:grid-cols-2 gap-2">
                                      {project.features.map((feature, i) => (
                                        <div 
                                          key={`feature-${index}-${i}`} 
                                          className="flex items-start space-x-2 text-sm text-slate-600 dark:text-slate-300"
                                        >
                                          <div className="w-1.5 h-1.5 bg-primary rounded-full mt-2 flex-shrink-0"></div>
                                          <span>{feature}</span>
                                        </div>
                                      ))}
                                    </div>
                                  </div>
                                )}
                              </div>
                            )}

                            {/* Action Buttons */}
                            <div className="flex flex-wrap gap-3">
                              {project.video_preview && (
                                <a
                                  className="flex-1 min-w-[120px] bg-primary hover:bg-primary/90 text-white font-semibold py-2.5 px-4 rounded-lg transition-all duration-200 hover:shadow-lg hover:shadow-primary/25 flex items-center justify-center group"
                                  href={project.video_preview}
                                  target="_blank"
                                  rel="noopener noreferrer"
                                >
                                  <svg className="w-4 h-4 mr-2 group-hover:scale-110 transition-transform" fill="currentColor" viewBox="0 0 20 20">
                                    <path d="M10 18a8 8 0 100-16 8 8 0 000 16zM9.555 7.168A1 1 0 008 8v4a1 1 0 001.555.832l3-2a1 1 0 000-1.664l-3-2z"/>
                                  </svg>
                                  Watch Demo
                                </a>
                              )}
                              {project.demo_url && (
                                <a
                                  className="flex-1 min-w-[120px] bg-green-600 hover:bg-green-700 text-white font-semibold py-2.5 px-4 rounded-lg transition-all duration-200 hover:shadow-lg hover:shadow-green-600/25 flex items-center justify-center group"
                                  href={project.demo_url}
                                  target={project.demo_url.startsWith('http') ? "_blank" : "_self"}
                                  rel={project.demo_url.startsWith('http') ? "noopener noreferrer" : ""}
                                >
                                  <svg className="w-4 h-4 mr-2 group-hover:scale-110 transition-transform" fill="currentColor" viewBox="0 0 20 20">
                                    <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-8.707l-3-3a1 1 0 00-1.414 1.414L10.586 9H7a1 1 0 100 2h3.586l-1.293 1.293a1 1 0 101.414 1.414l3-3a1 1 0 000-1.414z" clipRule="evenodd"/>
                                  </svg>
                                  Live Demo
                                </a>
                              )}
                              {project.repo_url && project.repo_url !== "#" && (
                                <a
                                  className="flex-1 min-w-[120px] border-2 border-slate-300 dark:border-slate-600 hover:border-primary dark:hover:border-primary text-slate-700 dark:text-slate-300 hover:text-primary dark:hover:text-primary font-semibold py-2.5 px-4 rounded-lg transition-all duration-200 hover:shadow-lg flex items-center justify-center group"
                                  href={project.repo_url}
                                  target="_blank"
                                  rel="noopener noreferrer"
                                >
                                  <svg className="w-4 h-4 mr-2 group-hover:scale-110 transition-transform" fill="currentColor" viewBox="0 0 20 20">
                                    <path fillRule="evenodd" d="M12.316 3.051a1 1 0 01.633 1.265l-4 12a1 1 0 11-1.898-.632l4-12a1 1 0 011.265-.633zM5.707 6.293a1 1 0 010 1.414L3.414 10l2.293 2.293a1 1 0 11-1.414 1.414l-3-3a1 1 0 010-1.414l3-3a1 1 0 011.414 0zm8.586 0a1 1 0 011.414 0l3 3a1 1 0 010 1.414l-3 3a1 1 0 11-1.414-1.414L16.586 10l-2.293-2.293a1 1 0 010-1.414z" clipRule="evenodd"/>
                                  </svg>
                                  View Code
                                </a>
                              )}
                            </div>
                          </div>
                        </div>
                      ))}
                    </div>
                  </div>
                </div>
              )}

              {/* Enhanced Experience Section */}
              {experiences?.enable && (
                <div className="py-20 bg-slate-50 dark:bg-slate-800" id="experience">
                  <div className="container">
                    <div className="text-center mb-16">
                      <h2 className="text-3xl md:text-4xl font-bold text-slate-900 dark:text-white mb-4">
                        Professional Experience
                      </h2>
                      <div className="w-24 h-1 bg-gradient-to-r from-primary to-blue-500 mx-auto mb-6"></div>
                      <p className="text-lg text-slate-600 dark:text-slate-300 max-w-2xl mx-auto">
                        My journey in building impactful solutions and leading successful initiatives
                      </p>
                    </div>
                    
                    <div className="max-w-4xl mx-auto">
                      {experiences?.list?.map((item, index) => (
                        <div key={`experience-${index}`} className="relative mb-12 last:mb-0">
                          {/* Timeline Line */}
                          {index !== experiences.list.length - 1 && (
                            <div className="absolute left-6 top-20 w-0.5 h-full bg-gradient-to-b from-primary to-blue-500 opacity-30"></div>
                          )}
                          
                          <div className="flex items-start space-x-6">
                            {/* Timeline Dot & Company Logo */}
                            <div className="relative flex-shrink-0">
                              <div className="w-12 h-12 bg-white dark:bg-slate-700 rounded-full border-4 border-primary shadow-lg flex items-center justify-center relative z-10">
                                {item.image ? (
                                  <ImageFallback
                                    className="w-8 h-8 rounded-full object-cover"
                                    src={item.image}
                                    alt={item.company}
                                    width={32}
                                    height={32}
                                  />
                                ) : (
                                  <svg className="w-6 h-6 text-primary" fill="currentColor" viewBox="0 0 20 20">
                                    <path fillRule="evenodd" d="M6 6V5a3 3 0 013-3h2a3 3 0 013 3v1h2a2 2 0 012 2v6a2 2 0 01-2 2H4a2 2 0 01-2-2V8a2 2 0 012-2h2zm4-3a1 1 0 00-1 1v1h2V4a1 1 0 00-1-1zm4 3H6v10h8V6z" clipRule="evenodd"/>
                                  </svg>
                                )}
                              </div>
                            </div>
                            
                            {/* Experience Content */}
                            <div className="flex-1 bg-white dark:bg-slate-700 rounded-xl shadow-lg hover:shadow-xl transition-all duration-300 p-6 border border-slate-200 dark:border-slate-600">
                              <div className="flex flex-col md:flex-row md:items-start md:justify-between mb-4">
                                <div>
                                  <h3 className="text-xl font-bold text-slate-900 dark:text-white mb-1">
                                    {item.title}
                                  </h3>
                                  <p className="text-primary font-semibold mb-1">
                                    {item.company}
                                    {item.location && (
                                      <span className="text-slate-500 dark:text-slate-400 font-normal ml-2">
                                        • {item.location}
                                      </span>
                                    )}
                                  </p>
                                </div>
                                <div className="bg-primary/10 text-primary px-3 py-1 rounded-full text-sm font-medium whitespace-nowrap">
                                  {item.duration}
                                </div>
                              </div>
                              
                              {item.description && (
                                <p className="text-slate-600 dark:text-slate-300 leading-relaxed mb-4">
                                  {item.description}
                                </p>
                              )}
                              
                              {item.highlights?.length > 0 && (
                                <div>
                                  <h4 className="text-sm font-semibold text-slate-900 dark:text-white mb-3 flex items-center">
                                    <svg className="w-4 h-4 mr-2 text-primary" fill="currentColor" viewBox="0 0 20 20">
                                      <path fillRule="evenodd" d="M11.3 1.046A1 1 0 0112 2v5h4a1 1 0 01.82 1.573l-7 10A1 1 0 018 18v-5H4a1 1 0 01-.82-1.573l7-10a1 1 0 011.12-.38z" clipRule="evenodd"/>
                                    </svg>
                                    Key Achievements
                                  </h4>
                                  <div className="grid grid-cols-1 gap-3">
                                    {item.highlights.map((highlight, i) => (
                                      <div 
                                        key={`experience-${index}-highlight-${i}`} 
                                        className="flex items-start space-x-3 text-sm text-slate-600 dark:text-slate-300"
                                      >
                                        <div className="w-1.5 h-1.5 bg-primary rounded-full mt-2 flex-shrink-0"></div>
                                        <span className="leading-relaxed">{highlight}</span>
                                      </div>
                                    ))}
                                  </div>
                                </div>
                              )}
                            </div>
                          </div>
                        </div>
                      ))}
                    </div>
                  </div>
                </div>
              )}

              {/* Enhanced Certifications Section */}
              {certifications?.enable && (
                <div className="py-20 bg-white dark:bg-slate-900" id="certifications">
                  <div className="container">
                    <div className="text-center mb-16">
                      <h2 className="text-3xl md:text-4xl font-bold text-slate-900 dark:text-white mb-4">
                        Certifications & Achievements
                      </h2>
                      <div className="w-24 h-1 bg-gradient-to-r from-primary to-blue-500 mx-auto mb-6"></div>
                      <p className="text-lg text-slate-600 dark:text-slate-300 max-w-2xl mx-auto">
                        Professional certifications that validate my expertise in cloud technologies and DevOps practices
                      </p>
                    </div>
                    
                    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 max-w-6xl mx-auto">
                      {certifications?.list?.map((cert, index) => (
                        <div 
                          key={`certification-${index}`}
                          className="group relative bg-white dark:bg-slate-800 rounded-xl shadow-lg hover:shadow-xl transition-all duration-500 overflow-hidden border border-slate-200 dark:border-slate-700 hover:border-primary/50 dark:hover:border-primary/50 hover:scale-105"
                        >
                          {/* Certification Badge */}
                          <div className="absolute top-4 right-4 z-10">
                            <div className="bg-primary/10 text-primary px-2 py-1 rounded-full text-xs font-semibold">
                              Certified
                            </div>
                          </div>
                          
                          {/* Certification Image */}
                          <div className="p-8 pb-4">
                            {cert.image ? (
                              <div className="relative mx-auto w-64 h-64 mb-6">
                                <div className="absolute inset-0 bg-gradient-to-r from-primary/20 to-blue-500/20 rounded-xl blur-xl group-hover:blur-xl transition-all duration-500"></div>
                                <ImageFallback
                                  className="relative z-10 w-full h-full object-contain rounded-xl group-hover:scale-110 transition-transform duration-500"
                                  src={cert.image}
                                  alt={cert.name}
                                  width={128}
                                  height={128}
                                />
                              </div>
                            ) : (
                              <div className="w-32 h-32 mx-auto mb-6 bg-gradient-to-br from-primary/20 to-blue-500/20 rounded-xl flex items-center justify-center group-hover:scale-110 transition-transform duration-500">
                                <svg className="w-16 h-16 text-primary" fill="currentColor" viewBox="0 0 20 20">
                                  <path fillRule="evenodd" d="M6.267 3.455a3.066 3.066 0 001.745-.723 3.066 3.066 0 013.976 0 3.066 3.066 0 001.745.723 3.066 3.066 0 012.812 2.812c.051.643.304 1.254.723 1.745a3.066 3.066 0 010 3.976 3.066 3.066 0 00-.723 1.745 3.066 3.066 0 01-2.812 2.812 3.066 3.066 0 00-1.745.723 3.066 3.066 0 01-3.976 0 3.066 3.066 0 00-1.745-.723 3.066 3.066 0 01-2.812-2.812 3.066 3.066 0 00-.723-1.745 3.066 3.066 0 010-3.976 3.066 3.066 0 00.723-1.745 3.066 3.066 0 012.812-2.812zm7.44 5.252a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd"/>
                                </svg>
                              </div>
                            )}
                          </div>
                          
                          {/* Certification Content */}
                          <div className="px-8 pb-8 text-center">
                            <h3 className="text-lg font-bold text-slate-900 dark:text-white mb-2 group-hover:text-primary transition-colors">
                              {cert.name}
                            </h3>
                            {cert.issuer && (
                              <p className="text-slate-600 dark:text-slate-300 font-medium mb-4">
                                {cert.issuer}
                              </p>
                            )}
                            
                            {/* Credential Button - Simplified for better functionality */}
                            <div className="mt-4">
                              <a
                                href={cert.credential_url}
                                target="_blank"
                                rel="noopener noreferrer"
                                className="block w-full text-center bg-primary hover:bg-blue-700 text-white font-semibold py-3 px-4 rounded-lg transition-colors duration-300 no-underline"
                              >
                                View Credential
                              </a>
                            </div>
                          </div>
                        </div>
                      ))}
                    </div>
                  </div>
                </div>
              )}
            </div>
          </div>
        </div>
      </section>
    </Base>
  );
 };

export default Home;

// for homepage data
 export const getStaticProps = async () => {
   const homepage = await getListPage("content/_index.md");
   const { frontmatter } = homepage;
   const { banner, projects, experiences, certifications } = frontmatter;

   return {
     props: {
       banner: banner,
       projects: projects || null,
       experiences: experiences || null,
       certifications: certifications || null,
     },
   };
 };
