Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445067FF2B3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345990AbjK3Omu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjK3Oms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:42:48 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82EE85
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:42:53 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SgzQf5chBz6D9Cn;
        Thu, 30 Nov 2023 22:41:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
        by mail.maildlp.com (Postfix) with ESMTPS id 4F4581404F6;
        Thu, 30 Nov 2023 22:42:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 Nov
 2023 14:42:50 +0000
Date:   Thu, 30 Nov 2023 14:42:48 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Huisong Li <lihuisong@huawei.com>
CC:     <xuwei5@hisilicon.com>, <linux-kernel@vger.kernel.org>,
        <soc@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <krzk@kernel.org>, <sudeep.holla@arm.com>,
        <liuyonglong@huawei.com>
Subject: Re: [PATCH v2 3/4] soc: hisilicon: kunpeng_hccs: remove an unused
 blank line
Message-ID: <20231130144248.00006d0f@Huawei.com>
In-Reply-To: <20231130134550.33398-4-lihuisong@huawei.com>
References: <20231109054526.27270-1-lihuisong@huawei.com>
        <20231130134550.33398-1-lihuisong@huawei.com>
        <20231130134550.33398-4-lihuisong@huawei.com>
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

On Thu, 30 Nov 2023 21:45:49 +0800
Huisong Li <lihuisong@huawei.com> wrote:

> Remove an unused blank line.
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
FWIW
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/soc/hisilicon/kunpeng_hccs.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
> index fd3ca0eb8175..15125f1e0f3e 100644
> --- a/drivers/soc/hisilicon/kunpeng_hccs.c
> +++ b/drivers/soc/hisilicon/kunpeng_hccs.c
> @@ -529,7 +529,6 @@ static int hccs_get_all_port_info_on_die(struct hccs_dev *hdev,
>  
>  static int hccs_query_all_port_info_on_platform(struct hccs_dev *hdev)
>  {
> -
>  	struct device *dev = hdev->dev;
>  	struct hccs_chip_info *chip;
>  	struct hccs_die_info *die;

