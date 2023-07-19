Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36350759097
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjGSIqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjGSIqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:46:42 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C77AFFC;
        Wed, 19 Jul 2023 01:46:39 -0700 (PDT)
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTPS Server V6.0(1455452:0:AUTH_RELAY)
        (envelope-from <alina_yu@richtek.com>)
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 19 Jul 2023 16:46:20 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Wed, 19 Jul
 2023 16:46:19 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Wed, 19 Jul 2023 16:46:19 +0800
Date:   Wed, 19 Jul 2023 16:46:19 +0800
From:   Alina Yu <alina_yu@richtek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <alina_yu@richtek.com>
Subject: Re: [PATCH v3 1/2] regulator: dt-bindings: rtq2208: Add Richtek
 RTQ2208 SubPMIC
Message-ID: <20230719084619.GA10314@linuxcarl2.richtek.com>
References: <1689740741-29244-1-git-send-email-alina_yu@richtek.com>
 <1689740741-29244-2-git-send-email-alina_yu@richtek.com>
 <860fffab-3c48-027d-aa2e-b15fc8f7a760@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <860fffab-3c48-027d-aa2e-b15fc8f7a760@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Krzysztof,

On Wed, Jul 19, 2023 at 09:43:03AM +0200, Krzysztof Kozlowski wrote:
> On 19/07/2023 06:25, alina_yu@richtek.com wrote:
> > From: alinayu <alina_yu@richtek.com>
> > 
> > Add bindings for Richtek RTQ2208 IC controlled SubPMIC
> > 
> > Signed-off-by: Alina Yu <alina_yu@richtek.com>
> > ---
> > v3
> > - Fix some typos
> > - Modify the descriptions for "richtek,mtp-sel"
> > - Modify the node name to lowercase and remove underscore
> > - Remove '|' from description
> > - Remove "regulator-compatible" from property
> > - Remove "regulator-state-mem" from pattern
> > - Modify node name to generic one
> > ---
> >  .../regulator/richtek,rtq2208-regulator.yaml       | 206 +++++++++++++++++++++
> >  1 file changed, 206 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rtq2208-regulator.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtq2208-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtq2208-regulator.yaml
> > new file mode 100644
> > index 0000000..2fc92e5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/regulator/richtek,rtq2208-regulator.yaml
> 
> No improvements here.
> 
> This is a friendly reminder during the review process.
> 
> It seems my previous comments were not fully addressed. Maybe my
> feedback got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all
> requested changes or keep discussing them.
> 
> Thank you.
> 
> Best regards,
> Krzysztof
> 


Sorry, I missed this one "Filename like compatible".
If I modify the filename to "richtek,rtq2208.yaml", is it unlike a compatible ?

Best regards,
Alina

