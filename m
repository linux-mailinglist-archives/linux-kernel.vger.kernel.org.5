Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FA0800423
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377612AbjLAGs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjLAGs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:48:58 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBE210FD;
        Thu, 30 Nov 2023 22:49:04 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id A97AD60476;
        Fri,  1 Dec 2023 06:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1701413344;
        bh=a77eqWj6N02PlXTg0SQW+aEQ3VVkxgGfzSwt//8DJg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L6+6NhpQmsh0XbTjmPEIujU28e0tMnGk8/2a0mTEhbmKuJXm5bIHsXQfFupGcpj2g
         tM+4uKaewsguRypyYUgVFXB0gHYcGrLJ5kX/ay4P+oNpNQtPsVKNNERTIuRpB7riTc
         Z2r27FlpwwZmh0jaJPcXNAG7YVGYt/HFPcVRcffil0JJ97yYsoOF2RUhFLWatvoLI/
         MZxEur2csAa8xyVneAstc7zJF1rHjZy+BoOiq73GaTNbkqzRBtgXDJL7XdU5HkI0Yh
         m/xqQ0Y8eAzdVFHlgGKRQ4WqI+5i7QP84YHhCL+L0V82SPHrU3d8krOENDY0V3PmlX
         IvhKcTP5OnCtw==
Date:   Fri, 1 Dec 2023 08:48:52 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     linux@armlinux.org.uk, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: omap2plus_defconfig: enable I2C devcies of bt200
Message-ID: <20231201064852.GG5169@atomide.com>
References: <20231120215635.4187399-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120215635.4187399-1-andreas@kemnade.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [231120 23:56]:
> Enable all available I2C drivers needed for the Epson Moverio BT200,
> that are:
> - LED
> - Subdevs of the TWL6032 PMIC
> - IMU sensors

Applying into omap-for-v6.8/defconfig thanks.

Tony
