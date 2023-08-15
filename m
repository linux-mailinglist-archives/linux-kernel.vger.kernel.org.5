Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2C177CCF5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbjHOMvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237316AbjHOMvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:51:23 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0262510C8;
        Tue, 15 Aug 2023 05:51:20 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8552E2E5;
        Tue, 15 Aug 2023 12:51:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8552E2E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1692103879; bh=A0ruRWbjJ2mUIDDgzFsVPpRpBtq2cd50AaJOZBXP32g=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mDxMI3HJR0f29YKulfklExT1CBFhIPj/ptRyN/d0v1i6unplWiQ5sQrTO6XwHgwvn
         3V3rb2D2q12tSKW12hf6BbiPC56C1EqifR8GIW4L6kmqfjmUMzpZwO9IxMDsBSwuWA
         dWlzZ/vg3ityq3sxA4j3Aii3zfYtVoJWQVpP2/P/wlLJ6mA6hN1xI9DEuskyJynJaL
         NB0t2nZxpskCCTf0YQBXbq7mY2fn2qM8f785PAf5w6rSMWgsybPc0Ub0WQcADfyDv/
         OBGRps7EPyK94KopfX7zGLlmeT7pSaD4Ccf0bn3RwN/05TVssvf/VVfkhidz7oXtOB
         UiKX34KlIVzDQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the jc_docs tree
In-Reply-To: <20230815121930.6174e047@canb.auug.org.au>
References: <20230815121930.6174e047@canb.auug.org.au>
Date:   Tue, 15 Aug 2023 06:51:18 -0600
Message-ID: <87cyzov589.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> The following commits are also in the arm-soc tree tree as different
> commits (but the same patches):
>
>   f92682a736be ("MAINTAINER: samsung: document dtbs_check requirement for Samsung")
>   e12cf84634f1 ("Documentation/process: maintainer-soc: add clean platforms profile")
>   1b46ecf119d8 ("MAINTAINERS: soc: reference maintainer profile")
>

They must have appeared in arm-soc today?  I applied them in July.  I
can happily drop them back out, though.

Thanks,

jon
