Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893CF78B762
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjH1SmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjH1Slv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:41:51 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290E5B0;
        Mon, 28 Aug 2023 11:41:49 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A2B6A723;
        Mon, 28 Aug 2023 18:41:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A2B6A723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1693248108; bh=AZ6LxylnitVyj6Ai841yUcCNXhRc0Ldtg8Q+cjgxpkw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=U6oYe9fzrxL+kUg52g0PKEndQFh++bxDXaqBXNRwEYyWMaw1rKvfQHPhCMzNm7g/T
         KyCa2lvbpx04VbqLmq6A/Nj29CTouYsunFZ7239wfgiwnsjN1Ygw22P6ry72iMaFZF
         AjaC3B3G4NLw3DaVpp/xyZuqtAi8xaBlVoKVo16ROE/TYbzIeEsRJJSJwZMi/ZKyF9
         Sv0DD9YiSz3uAN15heiN1Y3s599hkFI2I5bWXAdyZOXm0pGIUSG5mssIAbaueRhNFM
         KuEqmKxVaVGQEbIWsjwTxQgjRkoKsvxIgsY/VuiGuAcAHIOG6/Jr3OVYWF0pvwMlF7
         qTgH9O5e0A82Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Marco Pagani <marpagan@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Marco Pagani <marpagan@redhat.com>,
        Mika Penttila <mpenttil@redhat.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/mm: remove references to hmm_mirror ops and clean
 typos
In-Reply-To: <20230825133546.249683-1-marpagan@redhat.com>
References: <20230825133546.249683-1-marpagan@redhat.com>
Date:   Mon, 28 Aug 2023 12:41:47 -0600
Message-ID: <87fs43102c.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Pagani <marpagan@redhat.com> writes:

> Clean typos and remove the reference to the sync_cpu_device_pagetables()
> callback since all hmm_mirror ops have been removed.
>
> Fixes: a22dd506400d ("mm/hmm: remove hmm_mirror and related")
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> Reviewed-by: Mika Penttil=C3=A4 <mpenttil@redhat.com>
> ---
>  Documentation/mm/hmm.rst | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)

Applied, thanks.

jon
