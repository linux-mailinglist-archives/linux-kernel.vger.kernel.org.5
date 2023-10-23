Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770B37D2880
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 04:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjJWC1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 22:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjJWC1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 22:27:17 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DF719E;
        Sun, 22 Oct 2023 19:27:15 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2086A60A;
        Mon, 23 Oct 2023 02:27:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2086A60A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1698028035; bh=OUdMgOE8lLM8fr3KPSltNii1Sk8sBVdYUxhbf8Cjlv0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IiygKQoC/9AFrvAboKSaRrVCUJWs9GlXseNm1SStuxLU8YOaC/Kl88DrsuXUUV+p7
         DiGdMAF7Mqk4ZX9xKdH8UpimjbY14Azy93CAFBabJHJKRGw0A7QF6DIWUUk+tSa8P4
         KwWWlzewzlwvMOi/MKq9sTYvDzS1kmV0kY7Gogalz8Zy4pCvnLvbnxNw1HvuII+FIw
         78bZlLeerANO16MOKOXbFr81tpufb+rhwg4XJ8YLoQxHcmDDlukg5S+LZ6qg0zoGbU
         3RiWUbkkP97vfN9GWdW8I23TI/DCVFGSJDWfQhes66soak+w88g4v7EHsKscd4wuAo
         tI1TsfZBDwDmw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Min-Hua Chen <minhuadotchen@gmail.com>,
        Hu Haowen <src.res.211@gmail.com>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        kernel test robot <lkp@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: sparse: add SPDX-License-Identifier
In-Reply-To: <20231011233757.181652-1-minhuadotchen@gmail.com>
References: <20231011233757.181652-1-minhuadotchen@gmail.com>
Date:   Sun, 22 Oct 2023 20:27:14 -0600
Message-ID: <878r7ukr99.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Min-Hua Chen <minhuadotchen@gmail.com> writes:

> Add SPDX-License-Identifier to fix the checkpatch warning:
>
> WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> \#26: FILE: Documentation/translations/zh_TW/dev-tools/index.rst:1:
> +.. include:: ../disclaimer-zh_TW.rst
>
> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310110859.tumJoXFl-lkp@intel.com/
> ---
>  Documentation/translations/zh_TW/dev-tools/index.rst | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/translations/zh_TW/dev-tools/index.rst b/Documentation/translations/zh_TW/dev-tools/index.rst
> index 8f101db5a07f..e2e18a72ef94 100644
> --- a/Documentation/translations/zh_TW/dev-tools/index.rst
> +++ b/Documentation/translations/zh_TW/dev-tools/index.rst
> @@ -1,3 +1,5 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
>  .. include:: ../disclaimer-zh_TW.rst

Applied, thanks.

jon
