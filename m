Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB947CC3EB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343575AbjJQMxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbjJQMxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:53:12 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C7883;
        Tue, 17 Oct 2023 05:53:08 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4S8v345kbDz15Nct;
        Tue, 17 Oct 2023 20:50:24 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 17 Oct
 2023 20:53:06 +0800
Subject: Re: [PATCH net-next v11 1/6] page_pool: fragment API support for
 32-bit arch with 64-bit DMA
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Eric Dumazet <edumazet@google.com>
References: <20231013064827.61135-1-linyunsheng@huawei.com>
 <20231013064827.61135-2-linyunsheng@huawei.com>
 <CAC_iWj+FR+ojP7akSY0azc0hVnrhsPhyFTejNit0sVR742KgEw@mail.gmail.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <e738b0b9-6c60-b971-7fd9-0ec1b14dda3c@huawei.com>
Date:   Tue, 17 Oct 2023 20:53:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CAC_iWj+FR+ojP7akSY0azc0hVnrhsPhyFTejNit0sVR742KgEw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/17 20:17, Ilias Apalodimas wrote:
>>
> 
> That looks fine wrt what we discussed with Jakub,
> 
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Thanks. What about other patches in this series? Could you take
some time to review them too?

> 
> .
> 
