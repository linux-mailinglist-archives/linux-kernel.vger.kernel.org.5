Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789137B6E44
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240397AbjJCQVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjJCQVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:21:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41AF9E;
        Tue,  3 Oct 2023 09:21:19 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S0NKn0q8Wz67ydC;
        Wed,  4 Oct 2023 00:18:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 3 Oct
 2023 17:21:17 +0100
Date:   Tue, 3 Oct 2023 17:21:16 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andrew Jeffery <andrew@aj.id.au>
CC:     Konstantin Aladyshev <aladyshev22@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Corey Minyard <minyard@acm.org>,
        Patrick Venture <venture@google.com>,
        <openbmc@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        Tali Perry <tali.perry1@gmail.com>,
        "Avi Fishman" <avifishman70@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        netdev <netdev@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
        "Joel Stanley" <joel@jms.id.au>, Jakub Kicinski <kuba@kernel.org>,
        "Jeremy Kerr" <jk@codeconstruct.com.au>,
        Matt Johnston <matt@codeconstruct.com.au>,
        Paolo Abeni <pabeni@redhat.com>,
        <openipmi-developer@lists.sourceforge.net>,
        David Miller <davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>,
        "Benjamin Fair" <benjaminfair@google.com>
Subject: Re: [PATCH 3/3] mctp: Add MCTP-over-KCS transport binding
Message-ID: <20231003172116.0000736e@Huawei.com>
In-Reply-To: <1fd97872-446e-42f3-84ad-6e490d63e12d@app.fastmail.com>
References: <20230928123009.2913-1-aladyshev22@gmail.com>
        <20230928123009.2913-4-aladyshev22@gmail.com>
        <20230929120835.0000108e@Huawei.com>
        <1fd97872-446e-42f3-84ad-6e490d63e12d@app.fastmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Thanks for the drive-by comments!

No problem and keep up the good work in tidying this up.
Many dark and interesting corners in the kernel and not all of them get
the work they deserve :)

Feel free to CC me and I'll take a look at any cleanup you propose.
At least KCS is small so there aren't 100s of drivers to change :)

Jonathan

> 
> Andrew

