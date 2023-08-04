Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293DA76FD42
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjHDJ3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjHDJ3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:29:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C26E49FD;
        Fri,  4 Aug 2023 02:28:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9580C61F63;
        Fri,  4 Aug 2023 09:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C5AC433C8;
        Fri,  4 Aug 2023 09:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691141334;
        bh=lIsy3QbSaa0jvj/nU593HT1Vg+F9Mc8c+rYfDR9OfwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KcfLmQMYA67hqnXgMwiIufhP8gUMFyY1Elq9QeeJpROD48aIIeME42syiz9q3AQwP
         imEmm2z/KdLD5g7fOLuDNqCphH5bbw8gRWA5rOtW54DkNwOhvNgcX6FHN2crMGX73N
         nJdTaoneu2/rivvns+mzqZsGJddRoM4iBp8JwihDXpAyKWW/qP4I+nAdZPmmcZJXlB
         Cb9x5dYpDD8LG7L/uVNpeHPPl8+Ygb7MFDoM5qzS9ycqtG+KOpSv04pTBldd1b6bPs
         0DdEW+LkIt+HRqoH52kze7bCoEcwzuTCI+G665Fuw2VFylyWajGWbkSwOAGPp8SDFB
         Rgn7Z1xKbXCQg==
Date:   Fri, 4 Aug 2023 11:28:49 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, tech-board@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org
Subject: Re: [Tech-board] [PATCH] docs: Add a section on surveys to the
 researcher guidelines
Message-ID: <20230804-benehmen-mitmachen-bb004621cbce@brauner>
References: <87il9v7u55.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87il9v7u55.fsf@meer.lwn.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 02:23:02PM -0600, Jonathan Corbet wrote:
> It is common for university researchers to want to poll the community with
> online surveys, but that approach distracts developers while yielding
> little in the way of useful data.  Encourage alternatives instead.
> 
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
