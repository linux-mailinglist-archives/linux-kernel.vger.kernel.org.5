Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD197C04A1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjJJTaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbjJJTar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:30:47 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5809FC4;
        Tue, 10 Oct 2023 12:30:46 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D6C172B2;
        Tue, 10 Oct 2023 19:30:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D6C172B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1696966246; bh=pPJmFKhmB8FxDsFb+VAkIgqyGFD5ayeWmYIm6GKAjQU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QzQRrNDyoBetfX3v+IdXae79ajoDQMF/2Cf5jalFDzmBd0ZSnEQZD6VE+a9inGdH3
         peH/DOuxjrmMUSaIMrytTK/vfQeboelG0J5CQgV2a6/L6iaonCIzxcDwEGy+9Qp9Ur
         eImuwEYB40nigdnHTQ52vv7bKrIYYXLi8QpnOTqwd5VFIi4OcEdND8tAzUaQcF9F4Y
         RYzMBFTK0ZoEf30WEOxTk4IlSPEAZtSXGlij8HuEoA2IrifcbS3ELs75MlHLu0rkfB
         O8yy+FXhUAS3oqVKdiKkVRGqovnj5y8klmZSkTyVnulbqeVNCu6DMnYWvDbcfY5SD5
         IBNU30CVG0cDA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Costa Shulyupin <costa.shul@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>
Subject: Re: [PATCH] docs: update link to powerpc/vmemmap_dedup.rst
In-Reply-To: <20230927164319.2686237-1-costa.shul@redhat.com>
References: <20230927164319.2686237-1-costa.shul@redhat.com>
Date:   Tue, 10 Oct 2023 13:30:45 -0600
Message-ID: <87sf6i5l7e.fsf@meer.lwn.net>
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

Costa Shulyupin <costa.shul@redhat.com> writes:

> after move of powerpc/ to arch/
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  Documentation/mm/vmemmap_dedup.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/mm/vmemmap_dedup.rst b/Documentation/mm/vmemmap_dedup.rst
> index 59891f72420e..593ede6d314b 100644
> --- a/Documentation/mm/vmemmap_dedup.rst
> +++ b/Documentation/mm/vmemmap_dedup.rst
> @@ -211,7 +211,7 @@ the device (altmap).
>  
>  The following page sizes are supported in DAX: PAGE_SIZE (4K on x86_64),
>  PMD_SIZE (2M on x86_64) and PUD_SIZE (1G on x86_64).
> -For powerpc equivalent details see Documentation/powerpc/vmemmap_dedup.rst
> +For powerpc equivalent details see Documentation/arch/powerpc/vmemmap_dedup.rst
>  

Applied on top of the powerpc move, thanks.

jon
