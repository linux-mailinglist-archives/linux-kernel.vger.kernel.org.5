Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10DA800453
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377684AbjLAHGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjLAHGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:06:04 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA64D1729;
        Thu, 30 Nov 2023 23:06:10 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 5494060476;
        Fri,  1 Dec 2023 07:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1701414370;
        bh=RXpbKQwq6L7Fxm/0BkFGv54CyvhTReyPPdkffpuvbsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CwGaHDPbV2JUMhJAKfc8j7Oy8P/WEbo+xFfr15UKt2im8yKC2LOjQMJCewDqx96jE
         aSpg2thl/1PEa9AAgZ3zAxGK7PamGvw8cf4LGwEvS9y8pz32Pq9V7R0r8b/JvY3onO
         hL6fD6K/kf1NYVkvcgzntGzcqcsGH7plpBC1P0chyvE6IuaS6seg05FMm1yy7U3xVh
         kDAIW+LTJ/xqEvT34t5Q3LW1enGtJuC1kx9Msk2qc+/27leT2CBwMKeLItMVLfNd4I
         gqu3P9kcEH/z9f6T+MXXZ+3O/pNw6AFdQf0lk+BbDJBF38evhqGzPSl6ZxZSrbOAHe
         5hLhE3He+9HYg==
Date:   Fri, 1 Dec 2023 09:05:51 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: debug: reuse the config DEBUG_OMAP2UART{1,2} for
 OMAP{3,4,5}
Message-ID: <20231201070551.GJ5169@atomide.com>
References: <20231025112136.3445-1-lukas.bulwahn@gmail.com>
 <20231201070207.GI5169@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201070207.GI5169@atomide.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [231201 09:02]:
> * Lukas Bulwahn <lukas.bulwahn@gmail.com> [231025 14:21]:
> > Simply reuse the config DEBUG_OMAP2UART{1,2}; there is no need to define
> > separate config symbols for OMAP{3,4,5}. So, just delete the dead
> > references to DEBUG_OMAP{3,4,5}UART{1,2}.
> 
> Thanks applying into omap-for-v6.8/debug.

It's been already applied by Arnd, no need to do anything :)

Regards,

Tony
