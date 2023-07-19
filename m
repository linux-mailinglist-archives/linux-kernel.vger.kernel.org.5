Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9703758BA8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjGSC7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjGSC7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:59:41 -0400
Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com [115.124.28.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EF1130;
        Tue, 18 Jul 2023 19:59:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1746865|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0353264-0.00181599-0.962858;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=26;RT=26;SR=0;TI=SMTPD_---.Tx3JJXh_1689735568;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.Tx3JJXh_1689735568)
          by smtp.aliyun-inc.com;
          Wed, 19 Jul 2023 10:59:31 +0800
From:   wangweidong.a@awinic.com
To:     rdunlap@infradead.org
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        ckeepax@opensource.cirrus.com, colin.i.king@gmail.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        doug@schmorgal.com, fido_max@inbox.ru, flatmax@flatmax.com,
        herve.codina@bootlin.com, kiseok.jo@irondevice.com,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, liweilei@awinic.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, rf@opensource.cirrus.com,
        robh+dt@kernel.org, shumingf@realtek.com, tiwai@suse.com,
        trix@redhat.com, wangweidong.a@awinic.com, yijiangtao@awinic.com,
        zhangjianming@awinic.com
Subject: Re: [PATCH V1 4/5] ASoC: codecs: aw88261 chip register file, data type file and Kconfig Makefile
Date:   Wed, 19 Jul 2023 10:59:27 +0800
Message-ID: <20230719025928.41357-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <94068cfc-186a-1cac-0f76-77b3b46a85bd@infradead.org>
References: <94068cfc-186a-1cac-0f76-77b3b46a85bd@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Randy Dunlap,
 Thank you very much for your advice

> On 7/17/23 04:58, wangweidong.a@awinic.com wrote:
>> +config SND_SOC_AW88261
>> +	tristate "Soc Audio for awinic aw88261"

>	                        Awininc
> (as below)

I will modify it as suggested.

>> +	depends on I2C
>> +	select CRC8
>> +	select REGMAP_I2C
>> +	select GPIOLIB
>> +	select SND_SOC_AW88261_LIB
>> +	help
>> +	  this option enables support for aw88261 Smart PA.

	  This

>> +	  The Awinic AW88261 is an I2S/TDM input, high efficiency
>> +	  digital Smart K audio amplifier with an integrated 10.25V
>> +		smart boost convert.

> Less indentation on the last line (align it with the previous line).

I will modify it as suggested.

Best regards,
Weidong Wang
