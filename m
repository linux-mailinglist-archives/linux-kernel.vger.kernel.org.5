Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D55779D898
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbjILSX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236901AbjILSXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:23:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9D5115;
        Tue, 12 Sep 2023 11:23:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8926BC433C7;
        Tue, 12 Sep 2023 18:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694543030;
        bh=9PjwsXYdvGXo7MUL7wecpovXv5ZiPln8ttPB8U75U30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WiVa/+22NCGW7IrffV01g/GdWC+ihuiANID47Be41qQQoSSJ9MWdaOfhEb9E0Q5VN
         +r4kMs1yWdxu3fZxSMVAhcb1TNaDtndauRq5uWXU7mBetG9qmN4n6Ms8G4M3GnEpT6
         IL8BpNw0B4f3QGsuR4iJODP+YKbeKGtOxcoRwXCmSfOmpw58KNwvZgqZoqFU46XehM
         k5yjfS85vh+C4lBLsV3Gf18j3jx11EzTme/IAilZ+vPSeoagRxi7yNKtU2wB8T0SMM
         fviEL+q+o20LzIhi5DMS0RPSpg2+62je5UWbBK2PUNRUJjbewFTZnJJWrRJjpUPVGS
         Iyia4kBEwqV/g==
Received: (nullmailer pid 1158307 invoked by uid 1000);
        Tue, 12 Sep 2023 18:23:46 -0000
Date:   Tue, 12 Sep 2023 13:23:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Simon Horman <horms@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>,
        Fabio Estevam <festevam@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Dumazet <edumazet@google.com>,
        Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Jaroslav Kysel a <perex@perex.cz>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee@kernel.org>, Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH v5 07/31] dt-bindings: soc: fsl: cpm_qe: cpm1-scc-qmc:
 Add 'additionalProperties: false' in child nodes
Message-ID: <169454302597.1158257.5413851001884233921.robh@kernel.org>
References: <20230912081527.208499-1-herve.codina@bootlin.com>
 <20230912081527.208499-8-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912081527.208499-8-herve.codina@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Sep 2023 10:14:58 +0200, Herve Codina wrote:
> Additional properties in child node should not be allowed.
> 
> Prevent them adding 'additionalProperties: false'
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml     | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

