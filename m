Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E667745FB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjHHSuA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 8 Aug 2023 14:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjHHSta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:49:30 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F384E6EA9;
        Tue,  8 Aug 2023 10:01:23 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id A5F65831C;
        Tue,  8 Aug 2023 18:17:22 +0800 (CST)
Received: from EXMBX161.cuchost.com (172.16.6.71) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 8 Aug
 2023 18:17:22 +0800
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX161.cuchost.com
 (172.16.6.71) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 8 Aug
 2023 18:17:22 +0800
Received: from EXMBX068.cuchost.com ([fe80::e99c:4abb:32f:d650]) by
 EXMBX068.cuchost.com ([fe80::e99c:4abb:32f:d650%16]) with mapi id
 15.00.1497.044; Tue, 8 Aug 2023 18:17:22 +0800
From:   JiaJie Ho <jiajie.ho@starfivetech.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] riscv: dts: starfive - Add crypto and trng node
Thread-Topic: [PATCH 0/2] riscv: dts: starfive - Add crypto and trng node
Thread-Index: AQHZycgtdre3xH++D0m1ckikpOWjy6/gLsnA
Date:   Tue, 8 Aug 2023 10:17:22 +0000
Message-ID: <6c26992dca244c6eab05b64a16be0d0c@EXMBX068.cuchost.com>
References: <20230808061150.81491-1-jiajie.ho@starfivetech.com>
 <20230808-despair-calm-40ca60de2afb@spud>
In-Reply-To: <20230808-despair-calm-40ca60de2afb@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [161.142.156.69]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Aug 08, 2023 at 02:11:48PM +0800, Jia Jie Ho wrote:
> > The following patches add hardware cryptographic and trng module nodes
> > to JH7110 dts. Patches have been tested on VisionFive2 board.
> >
> > Best regards,
> > Jia Jie
> >
> > Jia Jie Ho (2):
> >   riscv: dts: starfive - Add crypto and DMA node for JH7110
> 
> >   riscv: dts: starfive - Add hwrng node for JH7110 SoC
> 
> I only got one patch, where is the other?

Hi Conor,
My mailing server failed to send out the 2nd patch.
Do I resend the patch or send it out together with other fixes in v2?

Thanks
Jia Jie
