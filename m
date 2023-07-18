Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AABD757842
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjGRJlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbjGRJlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:41:06 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6F71709;
        Tue, 18 Jul 2023 02:41:03 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4v5g2M4gz6J6gd;
        Tue, 18 Jul 2023 17:38:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 18 Jul
 2023 10:41:01 +0100
Date:   Tue, 18 Jul 2023 10:41:00 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     George Stark <gnstark@sberdevices.ru>,
        Jonathan Cameron <jic23@kernel.org>, <lars@metafoo.de>,
        <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 0/3] iio: adc: meson: tune init sequence
Message-ID: <20230718104100.00007c0c@Huawei.com>
In-Reply-To: <ZLURZWPkmP6aKDOZ@smile.fi.intel.com>
References: <20230715110654.6035-1-gnstark@sberdevices.ru>
        <20230716171134.43d05c45@jic23-huawei>
        <a172c764-1eef-835f-f237-8f78b4c6e877@sberdevices.ru>
        <ZLURZWPkmP6aKDOZ@smile.fi.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 13:01:09 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Jul 17, 2023 at 12:41:29PM +0300, George Stark wrote:
> > On 7/16/23 19:11, Jonathan Cameron wrote:  
> > > On Sat, 15 Jul 2023 14:05:57 +0300
> > > George Stark <gnstark@sberdevices.ru> wrote:  
> 
> ...
> 
> > > These look fine to me, but I'd like them to sit on list a little while
> > > on off chance anyone else has feedback on them.  
> > 
> > I understand. I'd resend the patches in a week or more if there's no
> > feedback.  
> 
> There is no need to resend as long as they are available via lore.kernel.org
> mail archives.
> 

FYI, I track using patchwork.kernel.org so rarely drop a patch set down the back of the
sofa any more...

Jonathan
