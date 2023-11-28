Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C78F7FC1CE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346761AbjK1PW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346750AbjK1PW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:22:27 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CA910D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:22:28 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SfmQm6lFjz6D8YL;
        Tue, 28 Nov 2023 23:22:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
        by mail.maildlp.com (Postfix) with ESMTPS id F06551408FF;
        Tue, 28 Nov 2023 23:22:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 Nov
 2023 15:22:25 +0000
Date:   Tue, 28 Nov 2023 15:22:24 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Huisong Li <lihuisong@huawei.com>
CC:     <xuwei5@hisilicon.com>, <linux-kernel@vger.kernel.org>,
        <soc@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <krzk@kernel.org>, <sudeep.holla@arm.com>,
        <liuyonglong@huawei.com>
Subject: Re: [PATCH v1 2/3] soc: hisilicon: kunpeng_hccs: Add failure log
 for no _CRS method
Message-ID: <20231128152224.00002bd8@Huawei.com>
In-Reply-To: <20231109054526.27270-3-lihuisong@huawei.com>
References: <20231109054526.27270-1-lihuisong@huawei.com>
        <20231109054526.27270-3-lihuisong@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2023 13:45:25 +0800
Huisong Li <lihuisong@huawei.com> wrote:

> Driver gets the PCC channel id by using the PCC GAS in _CRS.
> But, currently, if the firmware has no _CRS method on platform, there
> is not any failure log. So this patch adds the log for this.
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
Make sense to me.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
