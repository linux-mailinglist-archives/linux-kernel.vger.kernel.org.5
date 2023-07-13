Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E476751EDD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbjGMKah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjGMKag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:30:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAC7170E;
        Thu, 13 Jul 2023 03:30:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 725E860C43;
        Thu, 13 Jul 2023 10:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658CBC433C8;
        Thu, 13 Jul 2023 10:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689244231;
        bh=jZhMWDn5qcpv76c+RH3eVtIIbdScG8o0xsdtaplVF/g=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ItgwMLoLpkkdbMptMQ/aRnjItJ6k31tVTUnDn1mocyFj8pqslqqIlap9w+HWH3k+C
         k0J61fXsDlctIJj1vwlplCbtqWJ9ingNRE/ZZ2mnR0d8zZ2nOmCxpcqqGyQLrhRCE7
         EcdV+M2EfWUJMkbeokXhI/7opy9VV5eQl9RPjGD/7osTV8v7+GWTWqvyFXmrRiTqCL
         K7RTyBB1mvQzO2lnhP81Cuno2wf3W4v5bhdkVS25shK1jpIhkTF5hwyttA1O1mw+7G
         5SlEMYJBA0rdDg+9NYnE9tQOYybTBLQID40E/McAos3Fa8zyxnZUhlt5+7X002099A
         O9awqbGf3HGYg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: Closing down the wireless trees for a summer break?
References: <87y1kncuh4.fsf@kernel.org> <ZK7Yzd0VvblA3ONU@smile.fi.intel.com>
Date:   Thu, 13 Jul 2023 13:30:59 +0300
In-Reply-To: <ZK7Yzd0VvblA3ONU@smile.fi.intel.com> (Andy Shevchenko's message
        of "Wed, 12 Jul 2023 19:46:05 +0300")
Message-ID: <87wmz43xy4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@intel.com> writes:

> On Tue, Jun 13, 2023 at 05:22:47PM +0300, Kalle Valo wrote:
>
> ...
>
>> [1] https://phb-crystal-ball.sipsolutions.net/
>
> How could one use the shut down site?

What do you mean? At least from Finland it Works for me:

xps9310:~$ lynx -dump https://phb-crystal-ball.sipsolutions.net/ | head
Predictions

   Based on the last 74 kernel releases,with an average development time
      of 67 days, 20:19:25.986301,and merge window time of 13 days,
         17:02:03.364865,
              * the v6.5 kernel predictions: merge window closes on
      Sunday,
             2023-07-09 and release on Sunday, 2023-09-03
                  * the v6.6 kernel predictions: merge window closes on
      Sunday,
             2023-09-17 and release on Sunday, 2023-11-12
                  * the v6.7 kernel predictions: merge window closes on
      Sunday,

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
