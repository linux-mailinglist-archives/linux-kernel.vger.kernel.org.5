Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BCA7A254C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbjIOSEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236071AbjIOSEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:04:00 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458C619A9;
        Fri, 15 Sep 2023 11:03:54 -0700 (PDT)
X-QQ-mid: bizesmtp71t1694801018tm7ck7k8
Received: from [192.168.70.112] ( [125.75.40.56])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 16 Sep 2023 02:03:36 +0800 (CST)
X-QQ-SSF: 00200000000000907000B00A0000000
X-QQ-FEAT: znfcQSa1hKa76O0NSoBcNfW5D5vV/29gnVMAbIZwL2pDAw4Rf/UfbbAi+sxyq
        exM/gs+T2VoCB46b1F/MxncKegXLDia59h7Cbp9l7MYZPi89NbnrmpNSNfC0N+NLcYF4ZI/
        iQA3+qNLaqa33QVfZRIgmoidtp8xMFkuzYP/ScTz0l4HbPSTlZZcdnGlgnAavJpa6q9Y1z6
        kCA3iw3JrVSbyMQ0ECpDa5WTLAmPNgCrmS1WgrTutNBHsLL6KRoj9wTx5RhhjvGTMMuCzvp
        tucB6ujDpYNC8/gayiwqNcvbVUK8bhC+STv+rl6t22yMZpEc613mC05hECAyOzmTgtIYMwD
        EdQfsL3ur4KQKloSxs=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1828382361835151005
Message-ID: <0FD081215C60201D+d98c38d5-f4d8-472e-9c5f-b413ef10d3ed@tinylab.org>
Date:   Sat, 16 Sep 2023 02:03:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] MIPS: Simplify malta_defconfig
Content-Language: en-GB
To:     =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        tsbogend@alpha.franken.de, 42.hyeyoo@gmail.com
Cc:     linux-mips@vger.kernel.org, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, falcon@tinylab.org, w@1wt.eu,
        linux@weissschuh.net
References: <cover.1694680448.git.tanyuan@tinylab.org>
 <4d946232ffdd8891a32d4a9f17dbca10a4aa465d.1694680448.git.tanyuan@tinylab.org>
 <19e21e8c-95ea-362d-1ead-9369c211dba2@linaro.org>
From:   Yuan Tan <tanyuan@tinylab.org>
In-Reply-To: <19e21e8c-95ea-362d-1ead-9369c211dba2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: Yes, score=7.1 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_PBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *      [43.154.54.12 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [43.154.54.12 listed in list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  2.3 FORGED_MUA_MOZILLA Forged mail pretending to be from Mozilla
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/15/2023 9:35 PM, Philippe Mathieu-Daudé wrote:
> IMHO this should be squashed with the previous patch,
> to keep it "atomic", easing reverts or cherry-picks
> during backports.
Oh I will send v4 to squash these two patches :)

