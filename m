Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9F679CB5C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjILJQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjILJQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:16:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA8B10D8;
        Tue, 12 Sep 2023 02:16:47 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RlHy70wYbz6FGbr;
        Tue, 12 Sep 2023 17:16:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 10:16:44 +0100
Date:   Tue, 12 Sep 2023 10:16:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Conor Dooley <conor@kernel.org>,
        "Cusco, Ana-Maria" <Ana-Maria.Cusco@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: iio: hmc425a: add entry for HMC540S
Message-ID: <20230912101643.00005cc8@Huawei.com>
In-Reply-To: <06a007ad-ab6b-2ed0-8f70-6837680c8684@linaro.org>
References: <20230816110906.144540-1-ana-maria.cusco@analog.com>
        <20230816110906.144540-2-ana-maria.cusco@analog.com>
        <20230816-stoop-exonerate-148c7bdc01c2@spud>
        <SN7PR03MB7132732C9DB517378897DADA8EF1A@SN7PR03MB7132.namprd03.prod.outlook.com>
        <06a007ad-ab6b-2ed0-8f70-6837680c8684@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2023 08:56:56 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 12/09/2023 08:36, Hennerich, Michael wrote:
> > 
> >   
> >> -----Original Message-----
> >> From: Conor Dooley <conor@kernel.org>
> >> Sent: Mittwoch, 16. August 2023 16:37
> >> To: Cusco, Ana-Maria <Ana-Maria.Cusco@analog.com>
> >> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> >> <Michael.Hennerich@analog.com>; Jonathan Cameron <jic23@kernel.org>;
> >> Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> >> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> >> <conor+dt@kernel.org>; linux-iio@vger.kernel.org;
> >> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> >> Subject: Re: [PATCH 2/2] dt-bindings: iio: hmc425a: add entry for HMC540S
> >>
> >> [External]
> >>
> >> On Wed, Aug 16, 2023 at 02:09:06PM +0300, Ana-Maria Cusco wrote:  
> >>> Added support for HMC540SLP3E broadband 4-bit Silicon IC digital
> >>> attenuator with a 15 dB control range and wide frequency coverage
> >>> (0.1 to 8 GHz).
> >>>
> >>> Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>  
> >>
> >> Acked-by: Conor Dooley <conor.dooley@microchip.com>  
> > 
> > Adding missing Signed-off-by tag
> > 
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>  
> 
> Why it is missing? What is the purpose of this adding?
> 
> Best regards,
> Krzysztof
> 
> 

Wrong patch.  This is supposed to be on patch 1 where
Michael was the author (he confirmed intent in response to a
linux-next missing sign-off mail). I've added it there, but
if you can reply to that email Michael, it will make things nice
and clear.

Jonathan
