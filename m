Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108617D484D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjJXHTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbjJXHTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:19:44 -0400
Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com [115.124.28.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3938883;
        Tue, 24 Oct 2023 00:19:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08216741|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00473242-0.000100822-0.995167;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=27;RT=27;SR=0;TI=SMTPD_---.V6cJOiS_1698131969;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.V6cJOiS_1698131969)
          by smtp.aliyun-inc.com;
          Tue, 24 Oct 2023 15:19:38 +0800
From:   wangweidong.a@awinic.com
To:     broonie@kernel.org
Cc:     13916275206@139.com, ajye_huang@compal.corp-partner.google.com,
        alsa-devel@alsa-project.org, arnd@arndb.de,
        ckeepax@opensource.cirrus.com, colin.i.king@gmail.com,
        conor+dt@kernel.org, dan.carpenter@linaro.org,
        devicetree@vger.kernel.org, harshit.m.mogalapalli@oracle.com,
        herve.codina@bootlin.com, krzysztof.kozlowski+dt@linaro.org,
        lgirdwood@gmail.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, liweilei@awinic.com, perex@perex.cz,
        rf@opensource.cirrus.com, robh+dt@kernel.org, ryans.lee@analog.com,
        sebastian.reichel@collabora.com, shumingf@realtek.com,
        tiwai@suse.com, trix@redhat.com, wangweidong.a@awinic.com,
        yijiangtao@awinic.com
Subject: Re: [PATCH V2 3/4] ASoC: codecs: Add code for bin parsing compatible with aw88399
Date:   Tue, 24 Oct 2023 15:19:28 +0800
Message-ID: <20231024071929.88898-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <21bfa0bb-d936-402d-9ca9-6bcf181a0f35@sirena.org.uk>
References: <21bfa0bb-d936-402d-9ca9-6bcf181a0f35@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm very sorry, just sent the wrong patch, it was dut to my missteps.
Thank you very much for the review, but I have some questions 
I'd like to ask.

On Mon, Oct 23, 2023 at 13:29:03 +0100, broonie@kernel.org wrote:
> On Fri, Oct 20, 2023 at 04:34:25PM +0800, wangweidong.a@awinic.com wrote:
>> From: Weidong Wang <wangweidong.a@awinic.com>
>> 
>> Add aw88399 compatible code to the aw88395_lib.c file
>> so that it can parse aw88399's bin file.

> This doesn't apply against current code, please check and resend:

> Applying: ASoC: codecs: Add code for bin parsing compatible with aw88399
> Using index info to reconstruct a base tree...
> M	sound/soc/codecs/aw88395/aw88395_lib.c
> M	sound/soc/codecs/aw88395/aw88395_reg.h
> Falling back to patching base and 3-way merge...
> Auto-merging sound/soc/codecs/aw88395/aw88395_reg.h
> Auto-merging sound/soc/codecs/aw88395/aw88395_lib.c

I generated the patch based on the mainline branch, 
Why would there be a conflict? I know that I made a change to
this file when I committed aw87390 and that 
the change was in the Linux-next branch, but the two 
changes are in different parts of the file.

Best regards,
Weidong Wang


