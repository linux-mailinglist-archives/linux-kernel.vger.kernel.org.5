Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72717B828D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242899AbjJDOmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbjJDOmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:42:01 -0400
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E901C6;
        Wed,  4 Oct 2023 07:41:57 -0700 (PDT)
Date:   Wed, 4 Oct 2023 16:40:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
        t=1696430515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ktweLAm+dxlHaKntbD6u/jS8CnTcc3wre+3ER7F49m8=;
        b=aRguEn4Pv/E+1o0CSenNMFi2CqdX1ZU/GjpIuvn5iEHMC3VRlGaY2Vu4r+hzYVeqQ7SS7m
        bgGWVJDiG1IiuySZt+R+rAVCXOKo3Ap2L4SxFCOpjbqnjJ6kxCLWidiDSpEpJizrKGBkVY
        F8F7aWrUTwHHlHd7bxtyo1Ytqp6wx21WtEBlfPKFKOeZX1z9N2R6lP5ZeXm1pl3eRRZQvm
        DJ986Pb+pmzjsme/OcRtAZ0vdnoJ6qu2XxQhlKI3YSK5Azu0foiijGYcJBX4y66VSq3tLF
        U5WctFw4UpO59EsbbiIzLU4ia+S5+SCSOFCtIqGaXokCXPacXutpFdx2G8gz7A==
From:   Alexander Dahl <ada@thorsis.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v2] docs: submitting-patches: encourage direct
 notifications to commenters
Message-ID: <20231004-handbrake-unrelated-9e2ece2002cf@ifak-system.com>
Mail-Followup-To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Jani Nikula <jani.nikula@intel.com>
References: <20231003-docs-cc-reviewer-v2-1-f93fb946e21e@weissschuh.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231003-docs-cc-reviewer-v2-1-f93fb946e21e@weissschuh.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

Am Tue, Oct 03, 2023 at 08:30:03AM +0200 schrieb Thomas Weiﬂschuh:
> Commenters may not receive new versions of patches via the lists.
> Without a directed notification to them they might miss those new
> versions.
> 
> This is frustrating for the patch developers as they don't receive their
> earned Reviewed-by.
> It is also frustrating for the commenters, as they might think their
> review got ignored or they have to dig up new versions from the archive
> manually.
> 
> So encourage patch submitters to make sure that all commenters get
> notified also when no Reviewed-by was issued yet.

Appreciate your suggestion.  Not sure if every commenter would like to
be included in follow up iterations of a patch series, but for the few
things I comment on, I would be interested.

> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> Changes in v2:
> - s/reviewer/commenter/ to avoid ambiguity (Christoph)
> - Link to v1: https://lore.kernel.org/r/20230927-docs-cc-reviewer-v1-1-2af46ceb2d3c@weissschuh.net
> ---
>  Documentation/process/submitting-patches.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index efac910e2659..3245b7b38b98 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -327,6 +327,8 @@ politely and address the problems they have pointed out.  When sending a next
>  version, add a ``patch changelog`` to the cover letter or to individual patches
>  explaining difference against previous submission (see
>  :ref:`the_canonical_patch_format`).
> +Notify people that commented on your patch about new versions by adding them to
> +the patches CC list.

Acked-by: Alexander Dahl <ada@thorsis.com>

Greets
Alex

>  
>  See Documentation/process/email-clients.rst for recommendations on email
>  clients and mailing list etiquette.
> 
> ---
> base-commit: 633b47cb009d09dc8f4ba9cdb3a0ca138809c7c7
> change-id: 20230926-docs-cc-reviewer-023b3730af23
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <linux@weissschuh.net>
> 
