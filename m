Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A3F7FD46B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjK2KiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjK2Khs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:37:48 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF2D1BDD;
        Wed, 29 Nov 2023 02:37:54 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 476FD60514;
        Wed, 29 Nov 2023 10:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1701254274;
        bh=PZf6YQTupqFw4W6ycNWkH2Y3oi4tDcDahoqNRd4oPAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dd96a4lxNRCNkK9yNewLCH1VsdJ9qkKvd2m28A0GABSYsFx85rWBW9zVA4jBs/90M
         T8KqspvjNIduPFNhMRAHv8FfA3XzhPAwquakjhNCy+bkZgLK23RHa2FSvXPHcboR85
         E2+EkDYSbwPfWs1zOe5lTjSwWWge8JCHWe0hmArWGdYcR5l29zz/s1HaA5wEK08XM8
         Myzm3ChW8DnJaCcod0ENMsj74fv9mPSHH3eQhf0vyRKw5uSToOrFGpMYSjBXAl6YXU
         RRQx+a9F5aW7QwBRRQ8CntGdIkIR8Q8BWgENf261cIC7HDJELWJxffp0Kwea3VL1g8
         Y5WyLMTdS0pow==
Date:   Wed, 29 Nov 2023 12:37:15 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Thomas Richard <thomas.richard@bootlin.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        theo.lebrun@bootlin.com, u-kumar1@ti.com
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-j7200: use ti,j7200-padconf
 compatible
Message-ID: <20231129103715.GZ5169@atomide.com>
References: <20231128-j7200-pinctrl-s2r-v1-0-704e7dc24460@bootlin.com>
 <20231128-j7200-pinctrl-s2r-v1-3-704e7dc24460@bootlin.com>
 <20231129101905.GY5169@atomide.com>
 <9806d838-3eb8-406c-8ef9-f75ebe664078@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9806d838-3eb8-406c-8ef9-f75ebe664078@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Thomas Richard <thomas.richard@bootlin.com> [231129 10:32]:
> Thanks for the review.
> Yes the mcu registers are lost too, as the SoC is fully powered-off.
> And I did the test to confirm.

OK thanks for confirming it.

Tony
