import config from "@config/config.json";
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

      {/* Banner */}
      <section className="section banner relative pb-0">
        <ImageFallback
          className="absolute bottom-0 left-0 z-[-1] w-full"
          src={"/images/banner-bg-shape.svg"}
          width={1905}
          height={295}
          alt="banner-shape"
          priority
        />

        <div className="container">
          <div className="row flex-wrap-reverse items-center justify-center lg:flex-row">
            <div className={banner.image_enable ? "mt-12 text-center lg:mt-0 lg:text-left lg:col-6" : "mt-12 text-center lg:mt-0 lg:text-left lg:col-12"}>
              <div className="banner-title">
                {markdownify(banner.title, "h1")}
                {markdownify(banner.title_small, "span")}
              </div>
              {markdownify(banner.content, "p", "mt-4")}
              {banner.button.enable && (
                  <Link
                    className="btn btn-primary mt-6"
                    href={banner.button.link}
                    rel={banner.button.rel}
                  >
                    {banner.button.label}
                  </Link>
              )}
            </div>
            {banner.image_enable && (
                <div className="col-9 lg:col-6">
                  <ImageFallback
                    className="mx-auto object-contain"
                    src={banner.image}
                    width={548}
                    height={443}
                    priority={true}
                    alt="Banner Image"
                  />
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
              {/* Projects */}
              {projects?.enable && (
                <div className="section" id="projects">
                  {markdownify(projects.title, "h2", "section-title")}
                  <div className="rounded-lg border border-border p-6 dark:border-darkmode-border bg-gradient-to-br from-theme-light to-white dark:from-darkmode-theme-light dark:to-darkmode-body shadow-lg">
                    <div className="row">
                      {projects?.list?.map((project, index) => (
                        <div className="mb-8 md:col-6" key={`project-${index}`}> 
                          <div className="group h-full rounded-lg border border-border p-5 dark:border-darkmode-border bg-white dark:bg-darkmode-body hover:shadow-2xl transition-all duration-300 hover:scale-[1.02] hover:border-primary dark:hover:border-darkmode-primary">
                            {project.image && (
                              <div className="relative overflow-hidden rounded-lg mb-4">
                                <ImageFallback
                                  className="h-[220px] w-full rounded-lg object-cover transition-transform duration-300 group-hover:scale-110"
                                  src={project.image}
                                  alt={project.title}
                                  width={800}
                                  height={440}
                                />
                                <div className="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-end justify-center pb-4">
                                  <button
                                    onClick={() => setSelectedProject(selectedProject === index ? null : index)}
                                    className="text-white font-semibold text-sm bg-primary hover:bg-primary/90 px-4 py-2 rounded-full transition-all"
                                  >
                                    {selectedProject === index ? "Hide Details" : "View Details"}
                                  </button>
                                </div>
                              </div>
                            )}
                            <h3 className="h5 mb-2 text-dark dark:text-darkmode-dark font-bold">{project.title}</h3>
                            {project.description && <p className="mb-4 text-text dark:text-darkmode-text leading-relaxed">{project.description}</p>}
                            
                            {/* Technologies & Features - Show/Hide */}
                            {selectedProject === index && (
                              <div className="mb-4 space-y-3 animate-fade-in">
                                {project.technologies && (
                                  <div>
                                    <h4 className="text-sm font-semibold mb-2 text-dark dark:text-darkmode-dark">Technologies:</h4>
                                    <div className="flex flex-wrap gap-2">
                                      {project.technologies.map((tech, i) => (
                                        <span 
                                          key={`tech-${index}-${i}`} 
                                          className="px-3 py-1 text-xs font-medium bg-primary/10 text-primary dark:bg-darkmode-primary/10 dark:text-darkmode-primary rounded-full"
                                        >
                                          {tech}
                                        </span>
                                      ))}
                                    </div>
                                  </div>
                                )}
                                {project.features && (
                                  <div>
                                    <h4 className="text-sm font-semibold mb-2 text-dark dark:text-darkmode-dark">Key Features:</h4>
                                    <ul className="space-y-1">
                                      {project.features.map((feature, i) => (
                                        <li 
                                          key={`feature-${index}-${i}`} 
                                          className="text-sm text-text dark:text-darkmode-text flex items-start"
                                        >
                                          <span className="text-primary mr-2">✓</span>
                                          {feature}
                                        </li>
                                      ))}
                                    </ul>
                                  </div>
                                )}
                              </div>
                            )}

                            <div className="flex flex-wrap gap-3">
                              {project.demo_url && (
                                <a
                                  className="btn btn-primary flex-1 text-center hover:shadow-lg transition-shadow"
                                  href={project.demo_url}
                                  target="_blank"
                                  rel="noopener noreferrer"
                                >
                                  <span className="mr-1">🚀</span> Live Demo
                                </a>
                              )}
                              {project.repo_url && project.repo_url !== "#" && (
                                <a
                                  className="btn btn-outline-primary flex-1 text-center hover:shadow-lg transition-shadow"
                                  href={project.repo_url}
                                  target="_blank"
                                  rel="noopener noreferrer"
                                >
                                  <span className="mr-1">💻</span> View Code
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

              {/* Experience */}
              {experiences?.enable && (
                <div className="section" id="experience">
                  {markdownify(experiences.title, "h2", "section-title")}
                  <div className="rounded-lg border border-border p-6 dark:border-darkmode-border bg-gradient-to-br from-theme-light to-white dark:from-darkmode-theme-light dark:to-darkmode-body shadow-lg">
                    <div className="row">
                      {experiences?.list?.map((item, index) => (
                        <div className="mb-8 md:col-6" key={`experience-${index}`}>
                          <div className="h-full rounded-lg border border-border p-5 dark:border-darkmode-border bg-white dark:bg-darkmode-body hover:shadow-xl transition-all duration-300 hover:border-primary dark:hover:border-darkmode-primary">
                            <div className="flex items-start mb-3">
                              <div className="flex-shrink-0 w-10 h-10 bg-primary/10 dark:bg-darkmode-primary/10 rounded-full flex items-center justify-center mr-3">
                                <span className="text-primary dark:text-darkmode-primary text-lg font-bold">💼</span>
                              </div>
                              <div className="flex-1">
                                <h3 className="h5 mb-1 text-dark dark:text-darkmode-dark font-bold">{item.title}</h3>
                                <p className="mb-1 font-semibold text-primary dark:text-darkmode-primary">
                                  {item.company}
                                  {item.location ? ` • ${item.location}` : ""}
                                </p>
                                <p className="text-sm text-light dark:text-darkmode-light">{item.duration}</p>
                              </div>
                            </div>
                            {item.description && <p className="mb-4 text-text dark:text-darkmode-text leading-relaxed">{item.description}</p>}
                            {item.highlights?.length > 0 && (
                              <ul className="space-y-2">
                                {item.highlights.map((h, i) => (
                                  <li key={`experience-${index}-highlight-${i}`} className="text-sm text-text dark:text-darkmode-text flex items-start">
                                    <span className="text-primary mr-2 mt-1">•</span>
                                    <span>{h}</span>
                                  </li>
                                ))}
                              </ul>
                            )}
                          </div>
                        </div>
                      ))}
                    </div>
                  </div>
                </div>
              )}

              {/* Certifications */}
              {certifications?.enable && (
                <div className="section" id="certifications">
                  {markdownify(certifications.title, "h2", "section-title")}
                  <div className="rounded-lg border border-border p-6 dark:border-darkmode-border bg-gradient-to-br from-theme-light to-white dark:from-darkmode-theme-light dark:to-darkmode-body shadow-lg">
                    <div className="row">
                      {certifications?.list?.map((cert, index) => (
                        <div className="mb-6 md:col-6" key={`certification-${index}`}>
                          <div className="h-full rounded-lg border border-border p-5 dark:border-darkmode-border bg-white dark:bg-darkmode-body hover:shadow-xl transition-all duration-300 hover:border-primary dark:hover:border-darkmode-primary">
                            <div className="flex items-start">
                              <div className="flex-shrink-0 w-12 h-12 bg-primary/10 dark:bg-darkmode-primary/10 rounded-lg flex items-center justify-center mr-4">
                                <span className="text-primary dark:text-darkmode-primary text-2xl">🏆</span>
                              </div>
                              <div className="flex-1">
                                <h3 className="h5 mb-1 text-dark dark:text-darkmode-dark font-bold">{cert.name}</h3>
                                {cert.issuer && <p className="text-sm text-light dark:text-darkmode-light font-medium">{cert.issuer}</p>}
                              </div>
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
