Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D927E7C5068
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346323AbjJKKmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjJKKmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:42:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B63B692
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:42:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D3211480;
        Wed, 11 Oct 2023 03:42:47 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.38.165])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DA823F762;
        Wed, 11 Oct 2023 03:42:05 -0700 (PDT)
Date:   Wed, 11 Oct 2023 11:42:03 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] clocksource/drivers/arm_arch_timer: Initialize evtstrm
 after finalizing cpucaps
Message-ID: <ZSZ7-zjSq4hl66Ix@FVFF77S0Q05N.cambridge.arm.com>
References: <20230907133410.3817800-1-mark.rutland@arm.com>
 <a56ea45c-f1cb-4f9a-bfc9-d6af3282b13a@linaro.org>
 <ZSZsogqIgG863ucA@FVFF77S0Q05N>
 <500f7f18-65cf-4182-a174-5f0081456b3b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <500f7f18-65cf-4182-a174-5f0081456b3b@linaro.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 12:06:20PM +0200, Daniel Lezcano wrote:
> On 11/10/2023 11:36, Mark Rutland wrote:
> > On Wed, Oct 11, 2023 at 10:30:39AM +0200, Daniel Lezcano wrote:
> > > Applied thanks
> > 
> > This got folded into a larger series that we were hoping to take through the arm64 tree:
> > 
> >    https://lore.kernel.org/linux-arm-kernel/20231010103139.3113421-1-mark.rutland@arm.com/
> >    https://lore.kernel.org/linux-arm-kernel/20231010103139.3113421-2-mark.rutland@arm.com/
> > 
> > I think that won't conflict, since all that's changed is the commit text, but
> > it might be worth dropping this patch for now to avoid the risk of a conflict.
> 
> Sure, thanks for letting me know. I was suspecting that was the case :)
> 
> I've dropped it

Thanks, and sorry for the hassle!

Mark.
