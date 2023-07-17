Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295E275654D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjGQNmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjGQNmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:42:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3779A8F;
        Mon, 17 Jul 2023 06:42:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC48561068;
        Mon, 17 Jul 2023 13:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC48C433C8;
        Mon, 17 Jul 2023 13:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689601358;
        bh=IgXIQ0Pw02DZabIOlqO75heDWJNQl7wgVNHtLz4NMpg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kRwPpV6mbEioO44vyy50u59pDhc3ldVkROYA1afWDTiS+PlliaBjhzhkDo7yqgKCq
         jw2skSsBmSVvU3PytFSAv/KvCIVgnf/Ad8hwejh6WJB2jkMtX7aFkgIeKq7WmvMWud
         WqzhRMAtVL3mrr+dTiEkmgolw1ij0F05bgEean12lJ6BKqMSHxQLfNGvfaQ7OKFfgv
         gltblcTz84KQ9teY3ObxO2S+a6I+TitheM7U0UI9zFfyaJvJ3sStfi1cuw0wbEZO+6
         u9/7UZOJCfH7BgYb8TaTOsfK64Cx6sK/MJHRghNXWkNGFEzi5ocUmn5uCiHJNB9zg7
         XTkzVxRVC4+HQ==
Date:   Mon, 17 Jul 2023 15:42:32 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: error while fetching the v4l-dvb-fixes tree
Message-ID: <20230717154232.433f1055@coco.lan>
In-Reply-To: <20230717142248.281e3668@canb.auug.org.au>
References: <20230717142248.281e3668@canb.auug.org.au>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Em Mon, 17 Jul 2023 14:22:48 +1000
Stephen Rothwell <sfr@canb.auug.org.au> escreveu:

> Hi all,
> 
> Fetching the v4l-dvb-fixes tree produces this error:
> 
> fatal: couldn't find remote ref refs/heads/fixes

Could you please update the repository? We're now using a separate
repository for it:

	https://git.linuxtv.org/media_stage.git/ fixes

Regards,
Mauro
