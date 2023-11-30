Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39037FEE7C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345224AbjK3MDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345206AbjK3MDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:03:46 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181F8D40;
        Thu, 30 Nov 2023 04:03:53 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 9265660513;
        Thu, 30 Nov 2023 12:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1701345832;
        bh=ZB+5YYefmO6mtWWWUgT4TJQgoKAu1WOumvl/X7BvrBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uWAXf+L0fZHwcUkdeXJ6TRA8x43D22SAkOSHBWlh89dXu1bUme9JHQl9PzlKynOSP
         jgi0KRketGm1OXD8U2e5Q/bkjBgQ4lYicWaJ+6an3FPbY/uXBaHKepdfxqTgbi48w8
         Gr6I2xBkyRDOKOvt4BbKDh8sGMioP0ApjlJLNQKXblGD+UNZtlSWJ4jQb62Jvk92bD
         9OLjFQA5oZUtjtbOmAXyJ1Ziqo+INeoFm+ET0w8I770+O+0GJ9rKUG8RrWKcq5Jm74
         sE4KmR1NA3PMrInIOuLEvx851tSthWF6VjG9C9wgkehqeOXHkTGUpDb2PoJvwcoAHM
         6cT5uwfm1gl7w==
Date:   Thu, 30 Nov 2023 14:03:22 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lee@kernel.org, bcousson@baylibre.com, mturquette@baylibre.com,
        sboyd@kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 5/5] ARM: dts: omap4-embt2ws: enable 32K clock on WLAN
Message-ID: <20231130120322.GC5169@atomide.com>
References: <20230916100515.1650336-1-andreas@kemnade.info>
 <20230916100515.1650336-6-andreas@kemnade.info>
 <20231007065330.GP34982@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007065330.GP34982@atomide.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [231007 06:53]:
> * Andreas Kemnade <andreas@kemnade.info> [230916 13:05]:
> > WLAN did only work if clock was left enabled by the original system,
> > so make it fully enable the needed resources itself.
> 
> Seems applying this dts change before the clock patch is applied
> would break wlan so please let me know when this is safe to apply.

Applying into omap-for-v6.8/dt thanks.

Tony
