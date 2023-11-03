Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5743C7E054E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjKCPMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKCPMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:12:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99684D48
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 08:12:34 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SMPJT5mw5z67JwR;
        Fri,  3 Nov 2023 23:08:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 3 Nov
 2023 15:12:32 +0000
Date:   Fri, 3 Nov 2023 15:12:30 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andrew Jeffery <andrew@codeconstruct.com.au>
CC:     <minyard@acm.org>, <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <aladyshev22@gmail.com>,
        <jk@codeconstruct.com.au>
Subject: Re: [PATCH 10/10] ipmi: kcs_bmc: Add subsystem kerneldoc
Message-ID: <20231103151230.0000161e@Huawei.com>
In-Reply-To: <20231103061522.1268637-11-andrew@codeconstruct.com.au>
References: <20231103061522.1268637-1-andrew@codeconstruct.com.au>
        <20231103061522.1268637-11-andrew@codeconstruct.com.au>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Nov 2023 16:45:22 +1030
Andrew Jeffery <andrew@codeconstruct.com.au> wrote:

> Provide kerneldoc describing the relationships between and the
> behaviours of the structures and functions of the KCS subsystem.
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Seems reasonable but I've only a superficial idea of how this all fits
together so no tag from me.

There is the fun question of whether function documentation should be
next to the implementation or in the header.  As long as it's
consistent in a given subsystem I don't personally thing it matters
that much.

Jonathan
