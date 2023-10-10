Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C987BF9FF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjJJLmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjJJLmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:42:31 -0400
Received: from out28-58.mail.aliyun.com (out28-58.mail.aliyun.com [115.124.28.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7558F99;
        Tue, 10 Oct 2023 04:42:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1214311|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0259023-0.00112094-0.972977;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.UxYfX54_1696938141;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.UxYfX54_1696938141)
          by smtp.aliyun-inc.com;
          Tue, 10 Oct 2023 19:42:22 +0800
Date:   Tue, 10 Oct 2023 19:42:22 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.1 000/162] 6.1.57-rc1 review
Cc:     wqu@suse.com, stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
In-Reply-To: <2023101008-argue-impart-a6ad@gregkh>
References: <20231010161046.7861.409509F4@e16-tech.com> <2023101008-argue-impart-a6ad@gregkh>
Message-Id: <20231010194221.C1C3.409509F4@e16-tech.com>
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

> On Tue, Oct 10, 2023 at 04:10:48PM +0800, Wang Yugui wrote:
> > Hi,
> > 
> > > This is the start of the stable review cycle for the 6.1.57 release.
> > > There are 162 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> > > Anything received after that time might be too late.
> > 
> > 
> > drop this patch from 6.5/6.1/5.15/... please, 
> >   Qu Wenruo <wqu@suse.com>
> >      btrfs: reject unknown mount options early
> > 
> > becuase of this report.
> > https://lore.kernel.org/linux-btrfs/f3ac7b74-c011-4d1f-a510-677679fc9743@gmx.com/T/#t
> 
> Is there a revert somewhere for this already?

Yet not.

but we can suspend to apply this patch(drop this patch) for stable.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/10/10

