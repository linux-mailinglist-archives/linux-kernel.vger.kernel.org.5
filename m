Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9796758BB9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 05:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjGSDDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 23:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGSDDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:03:06 -0400
Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17735130;
        Tue, 18 Jul 2023 20:03:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09700525|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.00813514-0.000320179-0.991545;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=26;RT=26;SR=0;TI=SMTPD_---.Tx3STlc_1689735772;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.Tx3STlc_1689735772)
          by smtp.aliyun-inc.com;
          Wed, 19 Jul 2023 11:02:56 +0800
From:   wangweidong.a@awinic.com
To:     krzysztof.kozlowski@linaro.org
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
Subject: Re: [PATCH V1 5/5] ASoC: dt-bindings: Add schema for "awinic,aw88261"
Date:   Wed, 19 Jul 2023 11:02:52 +0800
Message-ID: <20230719030252.41396-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <192fa604-5fe6-c5c2-7fca-10f3a271b640@linaro.org>
References: <192fa604-5fe6-c5c2-7fca-10f3a271b640@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Krzysztof,
Thank you very much for your advice.

On 18/07/2023 16:24, krzysztof.kozlowski@linaro.org wrote:
> On 17/07/2023 13:58, wangweidong.a@awinic.com wrote:
>> From: Weidong Wang <wangweidong.a@awinic.com>
>> 
>> Add a DT schema for describing Awinic aw88261 audio amplifiers. They are
>> controlled using I2C.
>> 
>> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>

...

>> +  compatible:
>> +    const: awinic,aw88261
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  '#sound-dai-cells':
>> +    const: 0
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - '#sound-dai-cells'
>> +  - reset-gpios

> I don't see any differences against AW88395. Add the compatible to that
> schema.

I will add "awinic,aw88261" to the awinic,aw88395.yaml

Best regards,
Weidong Wang
