Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB49B766279
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 05:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjG1Dg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 23:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjG1Dgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 23:36:53 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9141B271E;
        Thu, 27 Jul 2023 20:36:51 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8Cx7+vQN8Nk6B8LAA--.26613S3;
        Fri, 28 Jul 2023 11:36:48 +0800 (CST)
Received: from [10.20.42.201] (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax8uTQN8NkcNM9AA--.33631S3;
        Fri, 28 Jul 2023 11:36:48 +0800 (CST)
Subject: Re: [PATCH v13 2/2] spi: loongson: add bus driver for the loongson
 spi controller
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        zhuyinbo@loongson.cn
References: <20230613075834.5219-1-zhuyinbo@loongson.cn>
 <20230613075834.5219-3-zhuyinbo@loongson.cn>
 <3822f248-39dc-fb8d-321a-7b6c833cbb3e@loongson.cn>
 <2264c9bd-76fb-4a99-b655-f4c7bc2a1d45@sirena.org.uk>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <8ad55123-fbf2-2b0f-faba-f71bb89c7fb1@loongson.cn>
Date:   Fri, 28 Jul 2023 11:36:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2264c9bd-76fb-4a99-b655-f4c7bc2a1d45@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Ax8uTQN8NkcNM9AA--.33631S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/27 下午7:37, Mark Brown 写道:
> On Thu, Jul 27, 2023 at 11:09:16AM +0800, Yinbo Zhu wrote:
> 
>> Friendly ping ?
> 
> Please don't send content free pings and please allow a reasonable time
> for review.  People get busy, go on holiday, attend conferences and so
> on so unless there is some reason for urgency (like critical bug fixes)
> please allow at least a couple of weeks for review.  If there have been
> review comments then people may be waiting for those to be addressed.


Sorry, my community experience is poor.  How many weeks does the
community usually take to review ?  and this time that I waited for six
weeks and then ping.

> 
> Sending content free pings adds to the mail volume (if they are seen at
> all) which is often the problem and since they can't be reviewed
> directly if something has gone wrong you'll have to resend the patches
> anyway, so sending again is generally a better approach though there are
> some other maintainers who like them - if in doubt look at how patches
> for the subsystem are normally handled.


Sorry, I don't got it, that free ping usually only needs to be sent to
the subsystem maintainer?

Not recommended to use free ping?  or resend the same patch.  If the
patch does not need to be modified, does it require sending the same
patch ?  And the version number remains the same?
> 

Thanks,
Yinbo

