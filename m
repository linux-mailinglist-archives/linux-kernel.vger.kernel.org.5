Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EF0768A42
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 05:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjGaDPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 23:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGaDPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 23:15:04 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90485E8;
        Sun, 30 Jul 2023 20:15:02 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8Bxyeo0J8dkqOwMAA--.21395S3;
        Mon, 31 Jul 2023 11:15:00 +0800 (CST)
Received: from [10.20.42.201] (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxWM0zJ8dkk75BAA--.42919S3;
        Mon, 31 Jul 2023 11:14:59 +0800 (CST)
Subject: Re: [PATCH v5 2/2] soc: loongson2_pm: add power management support
To:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, Liu Yun <liuyun@loongson.cn>,
        zhuyinbo@loongson.cn
References: <20230728074944.26746-1-zhuyinbo@loongson.cn>
 <20230728074944.26746-3-zhuyinbo@loongson.cn>
 <cefa57cf-2ff1-22f1-5cb3-ce0c04a30c57@infradead.org>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <9d96d0a6-b418-a45d-d616-51509e9afd8c@loongson.cn>
Date:   Mon, 31 Jul 2023 11:14:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <cefa57cf-2ff1-22f1-5cb3-ce0c04a30c57@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxWM0zJ8dkk75BAA--.42919S3
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



在 2023/7/28 下午8:17, Randy Dunlap 写道:
> Hi--
> 
> On 7/28/23 00:49, Yinbo Zhu wrote:
>> +config LOONGSON2_PM
>> +	bool "Loongson-2 SoC Power Management Controller Driver"
>> +	depends on LOONGARCH && OF
>> +	help
>> +	 The Loongson-2's power management controller was ACPI, supports ACPI
>> +	 S2Idle (Suspend To Idle), ACPI S3 (Suspend To RAM), ACPI S4 (Suspend To
>> +	 Disk), ACPI S5 (Soft Shutdown) and supports multiple wake-up methods
>> +	 (USB, GMAC, PWRBTN, etc.). This driver was to add power management
>> +	 controller support that base on dts for Loongson-2 series SoCs.
> 
> Kconfig help text should be indented with one tab +2 spaces, as documented
> in Documentation/process/coding-style.rst.


okay, I got it.

Thanks,
Yinbo

