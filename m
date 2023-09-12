Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5EE79CB8C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbjILJVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjILJVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:21:12 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CE0A9;
        Tue, 12 Sep 2023 02:20:29 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RlHxf2wgVz6J7qC;
        Tue, 12 Sep 2023 17:15:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 10:20:27 +0100
Date:   Tue, 12 Sep 2023 10:20:27 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Cusco, Ana-Maria" <Ana-Maria.Cusco@analog.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        <linux-iio@vger.kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the iio tree
Message-ID: <20230912102027.000047a9@Huawei.com>
In-Reply-To: <SN7PR03MB7132F1FD70D47658EC2AD7238EF1A@SN7PR03MB7132.namprd03.prod.outlook.com>
References: <20230912090544.50add67a@canb.auug.org.au>
        <SN7PR03MB7132F1FD70D47658EC2AD7238EF1A@SN7PR03MB7132.namprd03.prod.outlook.com>
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

On Tue, 12 Sep 2023 06:37:17 +0000
"Hennerich, Michael" <Michael.Hennerich@analog.com> wrote:

> > -----Original Message-----
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Sent: Dienstag, 12. September 2023 01:06
> > To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Cc: Hennerich, Michael <Michael.Hennerich@analog.com>; Cusco, Ana-
> > Maria <Ana-Maria.Cusco@analog.com>; Linux Kernel Mailing List <linux-  
> > kernel@vger.kernel.org>; Linux Next Mailing List <linux-
> > next@vger.kernel.org>  
> > Subject: linux-next: Signed-off-by missing for commit in the iio tree
> > 
> > 
> > Hi all,
> > 
> > Commit
> > 
> >   6ed193ca529e ("iio: amplifiers: hmc425a: Add Support HMC540S 4-bit
> > Attenuator")
> > 
> > is missing a Signed-off-by from its author.  
> 
> Replied and added my Signed-off-by to the original patch.
>  
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>

Hi Michael,

You missed and replied to the DT binding patch that followed this one.
I've taken above combined with that to be good enough confirmation that
you meant this one and added the sign off.  Great if you could confirm
that for the record though!

+CC linux-iio to keep the two discussions together.
+CC Krzysztof who asked about that rather odd looking SoB as well.

Jonathan

> 
> > 
> > --
> > Cheers,
> > Stephen Rothwell  

