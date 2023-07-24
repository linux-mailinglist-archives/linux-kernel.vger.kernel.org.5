Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B73760147
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjGXVhM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Jul 2023 17:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGXVhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:37:09 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE15126;
        Mon, 24 Jul 2023 14:37:05 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 1B9438213E;
        Mon, 24 Jul 2023 23:37:03 +0200 (CEST)
Date:   Mon, 24 Jul 2023 23:37:01 +0200
From:   =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.com
Subject: Re: [PATCH 09/10] dt-bindings: marvell: Document PXA1908 SoC
User-Agent: K-9 Mail for Android
In-Reply-To: <20230724141435.GA3378340-robh@kernel.org>
References: <20230721210042.21535-1-duje.mihanovic@skole.hr> <20230721210042.21535-10-duje.mihanovic@skole.hr> <5266764a-4551-4117-8aa4-bd435f63f450@linaro.org> <20230724141435.GA3378340-robh@kernel.org>
Message-ID: <D57F2E19-23DF-422D-9340-D76A877984F7@skole.hr>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On July 24, 2023 4:14:35 PM GMT+02:00, Rob Herring <robh@kernel.org> wrote:
>On Sat, Jul 22, 2023 at 11:27:21AM +0200, Krzysztof Kozlowski wrote:
>> On 21/07/2023 22:37, Duje Mihanović wrote:
>> > Add dt bindings and documentation for Marvell PXA1908 SoC.
>> > 
>> > Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
>> > ---
>> >  .../bindings/arm/marvell/marvell,pxa1908.yaml | 33 +++++++++++++++++++
>> >  1 file changed, 33 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,pxa1908.yaml
>> > 
>> > diff --git a/Documentation/devicetree/bindings/arm/marvell/marvell,pxa1908.yaml b/Documentation/devicetree/bindings/arm/marvell/marvell,pxa1908.yaml
>> > new file mode 100644
>> > index 000000000000..085d238129ad
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/arm/marvell/marvell,pxa1908.yaml
>> 
>> I suggest having one bindings file for all pxa platforms, not per one SoC.
>
>Or perhaps mirroring the new dts directory structure. PXA is really 
>multiple families. This one is more aligned with MMP than the 
>PXA2xx/3xx.
>
>Rob
>

