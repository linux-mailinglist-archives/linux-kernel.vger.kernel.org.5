Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1837A975E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjIURXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjIURWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:22:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0992817C01;
        Thu, 21 Sep 2023 10:07:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9E161688;
        Thu, 21 Sep 2023 06:30:43 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F9B33F5A1;
        Thu, 21 Sep 2023 06:30:05 -0700 (PDT)
Date:   Thu, 21 Sep 2023 14:30:02 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/13] PM: domains: Allow genpd providers to manage
 OPP tables directly by its FW
Message-ID: <20230921133002.dfyjkoe5f2pqxhc6@bogus>
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
 <20230825112633.236607-13-ulf.hansson@linaro.org>
 <20230921112019.gftlr5ys3yw2nwgw@bogus>
 <CAPDyKFpkjOFhjKMY=4dDgngi7PftE_4c+4dHE2KcGAGYnjk6-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpkjOFhjKMY=4dDgngi7PftE_4c+4dHE2KcGAGYnjk6-Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 03:05:17PM +0200, Ulf Hansson wrote:
> On Thu, 21 Sept 2023 at 13:20, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Fri, Aug 25, 2023 at 01:26:32PM +0200, Ulf Hansson wrote:
> > > In some cases the OPP tables aren't specified in device tree, but rather
> > > encoded in the FW. To allow a genpd provider to specify them dynamically
> > > instead, let's add a new genpd flag, GENPD_FLAG_OPP_TABLE_FW.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >
> > > Changes in v3:
> > >       - None.
> > >
> >
> > Just checking if I need Rafael's ack here or that is OK as you are
> > co-maintainer ? Again asking explicitly to ensure arm-soc is happy when
> > I send PR.
> 
> This should be fine for you to pick up. Rafael would have objected if
> this was something that he didn't like. Moreover, there's no other
> patches being queued for genpd at this moment so no worries of
> conflicts.
> 

Fair enough :), but I just wanted to confirm.

-- 
Regards,
Sudeep
