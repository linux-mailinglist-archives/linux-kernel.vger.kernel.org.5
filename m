Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E84769B83
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjGaP5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjGaP4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:56:35 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6645819AB;
        Mon, 31 Jul 2023 08:56:30 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3E56C2B0;
        Mon, 31 Jul 2023 15:56:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3E56C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1690818989; bh=170VgdjyfqLYYynBIfUDZpuFnGNn32j6gmkZ22Ep7Hg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fm46Fr+urb/tVaTP9PSofOV0EvGoO+WKdS42Cq2Ri5DJ/z9gxDw/hLanGwSlpMHJ9
         9GTQmM3C9qicj9Y+eLIR9pUWZqkJ8GKc4e9/pkHfJ7UwGifaVLTDCdn7q/JXLnBAxe
         jSIFIRWDeVtp0dVorBUuK7OcItFcljl34lv3wqiCPe2Cq+ypwOggLPa208J4q6oVfI
         SbePxHLnRr9Vz0KC9Rpsp61rjX5acSulajoeWT7ZnohiDK+c935X0B4hmpo/1i1PLj
         nfjLvDS6hNUCEV7EkBjMvkZwTdyMeQCNBHf5MylGXcBkCTYLXH0nhbugUh7INpmYFF
         cqZU+jRe3tT/w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Docs: kernel-parameters: sort the LEGEND list
In-Reply-To: <20230725174247.32393-1-rdunlap@infradead.org>
References: <20230725174247.32393-1-rdunlap@infradead.org>
Date:   Mon, 31 Jul 2023 09:56:28 -0600
Message-ID: <87jzugdqhf.fsf@meer.lwn.net>
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

Randy Dunlap <rdunlap@infradead.org> writes:

> Sort the list of kernel build options and hardware support options.
> Add a comment that the list should be kept sorted instead of having
> new options inserted willy nilly.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/admin-guide/kernel-parameters.rst |   23 +++++++-------
>  1 file changed, 12 insertions(+), 11 deletions(-)

Applied, thanks.

jon
