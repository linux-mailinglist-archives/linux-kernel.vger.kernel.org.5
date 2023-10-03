Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FA67B69D1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbjJCNGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjJCNGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:06:20 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05BD93;
        Tue,  3 Oct 2023 06:06:15 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 393D5ubr078279;
        Tue, 3 Oct 2023 08:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696338356;
        bh=MrFLaNBl/s0GYVJyufte6yFQiZGumC8D+qFQk57wCCM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=AQes4Kdgon5Mg1d/RaOuO41LXKTjsHxmqSKOYp3epo58Q4ab/fNUgOvZGKfM5Xhv1
         j8IMsyS+AKTQPwxxtTZ7pXevBBo7QPUfeMRw8LNc6KEbbio+iQb8QUvtCBf7WRLoWt
         vNHYs5996epR/T0943fGlYRXdFEjYTUW/Wc6Tgqs=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 393D5uPU010601
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Oct 2023 08:05:56 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 08:05:56 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 08:05:56 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 393D5uZH083516;
        Tue, 3 Oct 2023 08:05:56 -0500
Date:   Tue, 3 Oct 2023 08:05:56 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Ayush Singh <ayushdevel1325@gmail.com>
CC:     <greybus-dev@lists.linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <vaishnav@beagleboard.org>, <jkridner@beagleboard.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 1/3] dt-bindings: Add beaglecc1352
Message-ID: <20231003130556.ateaoj7der45dml6@huddle>
References: <20231002182454.211165-1-ayushdevel1325@gmail.com>
 <20231002182454.211165-2-ayushdevel1325@gmail.com>
 <20231003113017.z3yyjscvvinwnyy7@putdown>
 <706a8f30-847c-2641-aeee-6c4d4692e573@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <706a8f30-847c-2641-aeee-6c4d4692e573@gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:17-20231003, Ayush Singh wrote:
> > > +
> > > +  reset-gpios:
> > > +    maxItems: 1
> > > +
> > > +  power-gpios:
> > > +    maxItems: 3
> > > +    description:
> > > +      The device has three power rails that are exposed on external pins VDDS,
> > > +      VDDR and DCOUPL.
> > Shouldn't these be regulators? The power rails are input to the MCU,
> > correct?
> > The properties should be something like:
> > vdds-supply
> > vddr-supply
> > dcoupl-supply ? (not sure what dcoupl is, but description should provide
> > 		that info).
> > 
> > the gpio controls for those can be modelled by regulator-gpio ?
> 
> I picked up power lines from "CC13xx/CC26xx Hardware Configuration and PCB
> Design Considerations Application Report" present under "8.14 Network
> Processor" of CC1352P7 data sheet.
> 
> But now looking closer, it doesn't seem like DCOUPL can be supplied
> externally for CC1352P7 and thus should probably be removed.
> 
> Also, it seems like for CC1352P7, VDDR must always be supplied internally
> (The data sheet states: "Internal supply, must be powered from the internal
> DC/DC converter or the internal LDO"). Thus, it should be safe to remove
> VDDR as well.
From Figure 3-1. CC1312R 7x7 RF Part Schematic Overview (app report you
point out below)
Typical usage is vdds-supply supplying:
VDDS (pin 44)
VDDS2 (pin 13)
VDDS3 (pin 22)
VDDS_DCDC (pin 34)

And DCDC_SW (pin 33) supplies vddr supplying:
VDDR(pin 45)
VDDR_RF (Pin 48)

> 
> 
> That means only VDDS needs to be present for power line.

I agree that that would be the typical supply model. So, just
vdds-supply

> 
> 
> CC13xx/CC26xx Hardware Configuration and PCB Design Considerations
> Application Report: https://www.ti.com/lit/pdf/swra640
> 
> CC1352P7 Data sheet: https://www.ti.com/lit/gpn/CC1352P7

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
