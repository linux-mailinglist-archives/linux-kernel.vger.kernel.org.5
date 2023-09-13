Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1611B79F30A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 22:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjIMUnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 16:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjIMUng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:43:36 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0059C1BCA;
        Wed, 13 Sep 2023 13:43:31 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2D007240002;
        Wed, 13 Sep 2023 20:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694637810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W0sOhqE1ro8FJ/07SD/ZlWepR/goNctQcQxOm0XxSdw=;
        b=Blf/6hTCdjv8HD5vW+dZ+BTYMkVMLADC2dqpTFcsVgXryidEP5DyuxzA1VkG2E4I9Rv/nz
        yI0EZjDw6phG9nPo8HbcE5nrI4rkVagbTpniR0ztXQFCIhRJF9mJ2W1iiE7R2jeYzxeB91
        /AUL9sK/qL+zJ714AlnGLzb11iV/doJIYZErCaWRkfOhiFicwKBgo7kyTRM++DyDKq9yl0
        lsTC597HGj41yWPefPJu81CcrxfXaHvR1/PSAp5XfCFifyc1uvx1WV1M2tdb4attGYvUMu
        CIz0JjIA8zFi4jQ2DiY7Wmx4QJOEIzvLrZdsYPo696RJ2h/oLJief8L6d6rnKg==
Date:   Wed, 13 Sep 2023 22:43:27 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Ralph Siemsen <ralph.siemsen@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 1/2] clk: renesas: r9a06g032: fix kerneldoc warning
Message-ID: <20230913224327.01fbafbc@xps-13>
In-Reply-To: <20230913203805.465780-1-ralph.siemsen@linaro.org>
References: <20230913203805.465780-1-ralph.siemsen@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralph,

ralph.siemsen@linaro.org wrote on Wed, 13 Sep 2023 16:38:04 -0400:

> Mention the 'dual' structure in the kdoc. This fixes the following
> W=3D1 warning during build:
>=20
> > drivers/clk/renesas/r9a06g032-clocks.c:119: warning: Function parameter=
 or member 'dual' not described in 'r9a06g032_clkdesc' =20
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309101314.kTRoxND5-lkp@i=
ntel.com/
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
