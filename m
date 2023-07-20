Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EC275B081
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjGTNzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjGTNzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:55:20 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD7F1BFC;
        Thu, 20 Jul 2023 06:55:18 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1CE72733;
        Thu, 20 Jul 2023 13:55:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1CE72733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1689861318; bh=fRSr+vhJFM9EhKfQ3CXwQHHjz6rwzbsCTOFk9jIfB6k=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ICVBjvB0D7+whi7A9OUgBoGJD9YVCTQEpTxX38c+illoFpYIVcNVBWMvRK3SagYfK
         sGTqRZw/LDK16VObPohnW7+Cie0bnQ67nMkl9HWFavfxf2npjWmWHwdD5RWmm0Apu3
         HGoujiPaeH1m6/fuY5rQhYPi5mswUHx2ZnZ45/hYqCOlNBeLmkYOsjJphY1H6gwYD/
         OmV9dsGR1amA3q1L2CQgS/5V3T1xgrtyeZ+BaiY85Qf/cMsRueT+FXkovcbIl/9l3P
         NcZILylwLzn1bZUZLGgTVSnmBn/9xjRO3/HEv1YWOyJrf7gHVdVyfKlWhefgHiCyyY
         TwhyeZSfFZB2g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hu Haowen <src.res.211@gmail.com>
Cc:     Hu Haowen <src.res.211@gmail.com>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 0/6] docs/zh_TW: update zh_TW's documentation
 from an ascensive aspect
In-Reply-To: <20230720132729.1821-1-src.res.211@gmail.com>
References: <20230720132729.1821-1-src.res.211@gmail.com>
Date:   Thu, 20 Jul 2023 07:55:17 -0600
Message-ID: <877cqur8l6.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hu Haowen <src.res.211@gmail.com> writes:

> Update zh_TW's documentation concentrating on the following aspects:
>
>     * The file tree structure changes of the main documentation;
>     * Some changes and ideas from zh_CN translation;
>     * Removal for several obsoleted contents within the zh_TW translation
>       or those which are not exising anymore in the main documentation.
>     * Replacements for some incorrect words and phrases in traditional
>       Chinese or those which are odd within their context being hard for
>       readers to comprehend.

Is there a reason why you're resending a patch series from four days
ago?

Thanks,

jon
