Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D923B781242
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379176AbjHRRnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379226AbjHRRnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:43:06 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB223A9C;
        Fri, 18 Aug 2023 10:42:57 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 04DA56A2;
        Fri, 18 Aug 2023 17:42:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 04DA56A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1692380577; bh=GOuZkOaYIcVm6G5DEklRZvb7DKKG5wAQcJ+DPXnRRbA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YMaqL3Lk+U21d07jlrub/zazBd3wDGcTo4E5P9/izR9IFqS91TodVHcdzoBCCxGJb
         9e0067X410G+SJICzdwMF1OPfx2rzZ2qWmrg99BNun1IiMtaeTyKP29uu6VzCwdrOs
         10rgzquTvWiT6s7AU+MsTFAefnba1pACEwrAq5RCLicUipMuqjNxEvP9hd9n2aY54H
         Wp4PLiWT8CujuTH3PUdos73w+kIC6u860ZTvOVikB44ne3R53rGytbA63lZ+wF5gKp
         AwA579/iPF+4rYJWKiDZMRrdxCRljLaUT+7PRSEd9cJy1kRT2v/KpJ2/33mDw8j4pT
         b6EO0ubSI8YoA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-serial@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] Documentation: devices.txt: Remove ttyIOC*
In-Reply-To: <b5deb1222eb92017f0efe5b5cae127ac11983b3d.1691992627.git.christophe.leroy@csgroup.eu>
References: <b5deb1222eb92017f0efe5b5cae127ac11983b3d.1691992627.git.christophe.leroy@csgroup.eu>
Date:   Fri, 18 Aug 2023 11:42:56 -0600
Message-ID: <87il9cl00v.fsf@meer.lwn.net>
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

Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> IOC4 serial driver was removed, remove associated devices
> from documentation.
>
> Fixes: a017ef17cfd8 ("tty/serial: remove the ioc4_serial driver")
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  Documentation/admin-guide/devices.txt | 9 ---------
>  1 file changed, 9 deletions(-)

This doesn't apply to docs-next, seemingly as the result of a change
that went through Greg's tree, so these should follow the same path,
methinks.

Thanks,

jon
