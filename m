Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E617AD4D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjIYJuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYJut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:50:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E710A3;
        Mon, 25 Sep 2023 02:50:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 322F1DA7;
        Mon, 25 Sep 2023 02:51:21 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 272E33F59C;
        Mon, 25 Sep 2023 02:50:42 -0700 (PDT)
Date:   Mon, 25 Sep 2023 10:50:39 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Move power-domain driver to the
 pmdomain dir
Message-ID: <20230925095039.b4abieokjgxmobhs@bogus>
References: <20230919121605.7304-1-ulf.hansson@linaro.org>
 <20230921113328.3208651-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921113328.3208651-1-sudeep.holla@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 12:33:28PM +0100, Sudeep Holla wrote:
> To simplify with maintenance let's move the Arm SCMI power-domain driver
> to the new pmdomain directory.
> 
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
> 
> Hi Ulf,
> 
> If you are happy with this, please cck. I would like to take this along
> with your scmi_perf_domain change as part of you series.
> 
> Regards,
> Sudeep
> 
>  drivers/firmware/arm_scmi/Makefile                           | 1 -
>  drivers/pmdomain/arm/Makefile                                | 1 +
>  drivers/{firmware/arm_scmi => pmdomain/arm}/scmi_pm_domain.c | 0
>  3 files changed, 1 insertion(+), 1 deletion(-)
>  rename drivers/{firmware/arm_scmi => pmdomain/arm}/scmi_pm_domain.c (100%)
>

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/1] firmware: arm_scmi: firmware: arm_scmi: Move power-domain driver to thepmdomain dir
      https://git.kernel.org/sudeep.holla/c/af78e5c309c4

-- 
Regards,
Sudeep
