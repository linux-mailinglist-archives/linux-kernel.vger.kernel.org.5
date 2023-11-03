Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2207E04C3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377824AbjKCOe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377800AbjKCOe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:34:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217A5CA
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 07:34:24 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SMNTS66jzz6K5d1;
        Fri,  3 Nov 2023 22:31:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 3 Nov
 2023 14:34:22 +0000
Date:   Fri, 3 Nov 2023 14:34:21 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andrew Jeffery <andrew@codeconstruct.com.au>
CC:     <minyard@acm.org>, <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <aladyshev22@gmail.com>,
        <jk@codeconstruct.com.au>
Subject: Re: [PATCH 01/10] ipmi: kcs_bmc: Update module description
Message-ID: <20231103143421.00006e7a@Huawei.com>
In-Reply-To: <20231103061522.1268637-2-andrew@codeconstruct.com.au>
References: <20231103061522.1268637-1-andrew@codeconstruct.com.au>
        <20231103061522.1268637-2-andrew@codeconstruct.com.au>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Nov 2023 16:45:13 +1030
Andrew Jeffery <andrew@codeconstruct.com.au> wrote:

> KCS devices are often used for IPMI, but they're not constrained to it.
> Update the subsystem module description to reflect its more general
> capabilities.
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
LTGM, FWIW,

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/char/ipmi/kcs_bmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
> index 8b1161d5194a..a429d9f8a7bf 100644
> --- a/drivers/char/ipmi/kcs_bmc.c
> +++ b/drivers/char/ipmi/kcs_bmc.c
> @@ -187,4 +187,4 @@ EXPORT_SYMBOL(kcs_bmc_update_event_mask);
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Haiyue Wang <haiyue.wang@linux.intel.com>");
>  MODULE_AUTHOR("Andrew Jeffery <andrew@aj.id.au>");
> -MODULE_DESCRIPTION("KCS BMC to handle the IPMI request from system software");
> +MODULE_DESCRIPTION("Subsystem for BMCs to communicate via KCS devices");

