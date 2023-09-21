Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98FE7A9E3C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjIUT67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjIUT6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:58:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 202DC46DC0;
        Thu, 21 Sep 2023 10:13:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC3BD168F;
        Thu, 21 Sep 2023 06:34:23 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E02E23F5A1;
        Thu, 21 Sep 2023 06:33:45 -0700 (PDT)
Date:   Thu, 21 Sep 2023 14:33:43 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Move power-domain driver to the
 pmdomain dir
Message-ID: <20230921133343.h3chbszl2iuf2b55@bogus>
References: <20230919121605.7304-1-ulf.hansson@linaro.org>
 <20230921113328.3208651-1-sudeep.holla@arm.com>
 <CAPDyKFrGDZzyp4G1fS5PGCE95b3_w4kJyZfnDs=BEuYLzJ7uXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrGDZzyp4G1fS5PGCE95b3_w4kJyZfnDs=BEuYLzJ7uXA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 03:10:56PM +0200, Ulf Hansson wrote:
> On Thu, 21 Sept 2023 at 13:33, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > To simplify with maintenance let's move the Arm SCMI power-domain driver
> > to the new pmdomain directory.
> >
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Cristian Marussi <cristian.marussi@arm.com>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Feel free to take it through your scmi tree!
> 
> Note that, we should move the Kconfig options too, but that requires
> changes that I am carrying in my pmdomain tree. We can either wait
> until the next cycle or you could send your pull-request to me this
> time (instead of through arm-soc), then we can fix this as a late
> minute change. The decision is yours.
> 

OK. Lets us just delay SCMI Kconfig changes for the next cycle then. I assume
you would have other changes merged by then. Or may be as a fix as it would
be hardlt 10-15 line with 2 Kconfig options. Let me know if you disagree or
have other ideas.

-- 
Regards,
Sudeep
