Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFA27A9E3A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjIUT7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjIUT6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:58:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20FEF46DC3;
        Thu, 21 Sep 2023 10:13:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35FE01692;
        Thu, 21 Sep 2023 06:36:26 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A5313F5A1;
        Thu, 21 Sep 2023 06:35:47 -0700 (PDT)
Date:   Thu, 21 Sep 2023 14:35:44 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 08/13] dt-bindings: arm: cpus: Add a power-domain-name
 for a performance-domain
Message-ID: <20230921133544.sxzpo3xyrttnrtzt@bogus>
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
 <20230825112633.236607-9-ulf.hansson@linaro.org>
 <20230921111110.tbffr5sik3ycw7gf@bogus>
 <CAPDyKFrSkgSee=8zruR65TALvAj+hcWw1CaUOUwD3EpdxymtBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrSkgSee=8zruR65TALvAj+hcWw1CaUOUwD3EpdxymtBg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 03:22:54PM +0200, Ulf Hansson wrote:
> On Thu, 21 Sept 2023 at 13:11, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Fri, Aug 25, 2023 at 01:26:28PM +0200, Ulf Hansson wrote:
> > > When an CPU's performance domain is managed through the SCMI firmware,
> > > let's enable us describe this as a consumer of a power-domain provider,
> > > which is the de-facto standard to use for performance domains. In this
> > > case, let's specify a corresponding power-domain-name, to point out the
> > > corresponding index for it.
> > >
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > > Cc: Conor Dooley <conor+dt@kernel.org>
> > > Cc: devicetree@vger.kernel.org
> > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >
> > > Changes in v3:
> > >       - New patch.
> >
> > This patch and 10/13 are quite generic. I am happy to take it as part of
> > this series but just thought of checking again if that is what you prefer ?
> 
> Yes please, go ahead and pick this up through your scmi tree.
> 

Thanks, I just need Viresh's ack for cpufreq changes, we are otherwise all
set with the series. I will pull once I have his ack.

-- 
Regards,
Sudeep
