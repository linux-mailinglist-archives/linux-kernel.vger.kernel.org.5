Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030917BF559
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442622AbjJJIK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbjJJIKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:10:55 -0400
Received: from out28-55.mail.aliyun.com (out28-55.mail.aliyun.com [115.124.28.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EC49F;
        Tue, 10 Oct 2023 01:10:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2143427|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0608247-0.000652269-0.938523;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.UxOHShu_1696925447;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.UxOHShu_1696925447)
          by smtp.aliyun-inc.com;
          Tue, 10 Oct 2023 16:10:48 +0800
Date:   Tue, 10 Oct 2023 16:10:48 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, wqu@suse.com
Subject: Re: [PATCH 6.1 000/162] 6.1.57-rc1 review
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
Message-Id: <20231010161046.7861.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> This is the start of the stable review cycle for the 6.1.57 release.
> There are 162 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.


drop this patch from 6.5/6.1/5.15/... please, 
  Qu Wenruo <wqu@suse.com>
     btrfs: reject unknown mount options early

becuase of this report.
https://lore.kernel.org/linux-btrfs/f3ac7b74-c011-4d1f-a510-677679fc9743@gmx.com/T/#t


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/10/10



