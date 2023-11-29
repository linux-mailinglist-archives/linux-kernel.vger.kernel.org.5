Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B41A7FD3D5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjK2KQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjK2KQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:16:08 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5D6C4;
        Wed, 29 Nov 2023 02:16:15 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 61B29603F4;
        Wed, 29 Nov 2023 10:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1701252974;
        bh=L/eV/0fIB7OL8iIm/1Q/TNqJah06A0ocA8A8tBMVvGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DqijIydbV8fHBr6ftecfvoR+1xhJRxVErWKVOPIDtD63ROz84ZMm6F80SoWOJbmd/
         s9dyXk8duKVCXmNGabn9QbYN37QTUCavuABFw4tJgfAT0OkbXJC8otwwJQDYgS6uXN
         mdOnnvs3xC9pMxN297FOFHhlDpntdFeX3Agj0dZyL5OffSxV0qovPWkNy6pWf7Png4
         njmjw+ZfwYlkw1kF2qVLZOc/lEbWG5bG7GsxetQNrmCvpdj2r97nC1jyNSguT+DWCj
         ullrpOXA+gFEsAz6vffiIAOl/12mc+MHQACCctR4S+a3BVFZ3ivBa46145+SYWs21y
         AcaJ5J5a68Dgw==
Date:   Wed, 29 Nov 2023 12:15:35 +0200
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
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: pinctrl-single: add
 ti,j7200-padconf compatible
Message-ID: <20231129101535.GW5169@atomide.com>
References: <20231128-j7200-pinctrl-s2r-v1-0-704e7dc24460@bootlin.com>
 <20231128-j7200-pinctrl-s2r-v1-1-704e7dc24460@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128-j7200-pinctrl-s2r-v1-1-704e7dc24460@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Thomas Richard <thomas.richard@bootlin.com> [231128 15:35]:
> Add the "ti,j7200-padconf" compatible to support suspend to ram on
> j7200.

Reviewed-by: Tony Lindgren <tony@atomide.com>
