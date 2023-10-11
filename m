Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF077C4CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjJKIQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjJKIPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:15:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E54292;
        Wed, 11 Oct 2023 01:15:52 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S55Bh3CbLz6K5rr;
        Wed, 11 Oct 2023 16:13:48 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 09:15:48 +0100
Date:   Wed, 11 Oct 2023 09:15:48 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        <jic23@kernel.org>
Subject: Re: linux-next: duplicate patch in the iio tree
Message-ID: <20231011091548.0000396b@Huawei.com>
In-Reply-To: <20231011081114.2f4d36e4@canb.auug.org.au>
References: <20231011081114.2f4d36e4@canb.auug.org.au>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 08:11:14 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> The following commit is also in Linus Torvalds' tree as a different commit
> (but the same patch):
> 
>   25a0741b55b1 ("dt-bindings: trivial-devices: Fix MEMSIC MXC4005 compatible string")
> 
> This is commit
> 
>   19007c629c63 ("dt-bindings: trivial-devices: Fix MEMSIC MXC4005 compatible string")
> 
> in Linus' tree.
> 

That's near the top of my tree so fixing it shouldn't make too much of a mess.
I'll drop it when I'm next on the right machine.

Thanks,

Jonathan
