Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D872978A214
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 23:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjH0Vtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 17:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjH0Vtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 17:49:35 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8706B119;
        Sun, 27 Aug 2023 14:49:32 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7C280240005;
        Sun, 27 Aug 2023 21:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693172971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X1A41XLxiGjxOXQQYjkjIEZWNYJ8/Qz7bBby00Az0O0=;
        b=EC5HzCEh0AvIIP0SqBdPnGdLACH4bx6Lk7ekPxEK09ugjkAOnj+ksdmjleZIg7iYu4FOp2
        IxxGyTyAnjEyok2rwnJGWA7Iy1PvdzVOLbR6mkGWTZBWlHxgaZ3cCZxxXAIRXMZw0mhZMn
        9tTIToDmEoI2IkLF09ZEcA6tgErqAW9kDAPB5jwisfyY+n0z9SZyEQpucKruQgMd6Tolc+
        ZFbxNYeVbDfh+6HjrPv8Mtn67EYLVzZ/OCh8uYdsSUA7eo3bULHJeAabPk3CKxHc7G0ULC
        Mg/IfiahTdnYXorMA4cIVRfIdTj1OZbELq+18CrLysrVoRl+jUMAgtaELOS18Q==
Date:   Sun, 27 Aug 2023 23:49:30 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: remove obsolete pattern in RTC SUBSYSTEM
 section
Message-ID: <169317294154.537637.1894827530197722432.b4-ty@bootlin.com>
References: <20230825053910.17941-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825053910.17941-1-lukas.bulwahn@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 25 Aug 2023 07:39:10 +0200, Lukas Bulwahn wrote:
> Commit d890cfc25fe9 ("rtc: ds2404: Convert to GPIO descriptors") removes
> the rtc-ds2404.h platform data and with that, there is no file remaining
> matching the pattern 'include/linux/platform_data/rtc-*'. Hence,
> ./scripts/get_maintainer.pl --self-test=patterns complains about a broken
> reference.
> 
> Remove the obsolete file pattern in the REAL TIME CLOCK (RTC) SUBSYSTEM.
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: remove obsolete pattern in RTC SUBSYSTEM section
      commit: 45cc2a7de905a1f3bb38fb7d6f68a204c71630be

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
