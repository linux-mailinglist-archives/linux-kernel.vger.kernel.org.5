Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF5D7A8B1B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjITSFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjITSFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:05:49 -0400
Received: from gimli.kloenk.dev (gimli.kloenk.dev [IPv6:2a01:4f8:c012:b874::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EA6C9;
        Wed, 20 Sep 2023 11:05:43 -0700 (PDT)
From:   Finn Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
        t=1695233141; bh=aelmzdlktMzG97R1JnkYq1JCbq8afJEne6diWnvrLbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Wfca2MTUJ2AwZDltSv0Rqk//Ug0RJ8Rv1IMxyEdGQItJ8KwGt493Sf18OuNEC0/KW
         xMgnE2LKz9j31WZTkgxgCa9vjhvbwyqyzjuU0RRxGDeC0aegBe2YmHgRORYqQehSzR
         9CDoO5JyYlx5XZGgY/mJBq4045yZqxegA8s+pM1Q=
To:     Manmohan Shukla <manmshuk@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: error: Markdown style nit
Date:   Wed, 20 Sep 2023 20:05:40 +0200
Message-ID: <27211D21-4A09-48B0-B51F-1C353BEDC784@kloenk.dev>
In-Reply-To: <20230906204857.85619-1-manmshuk@gmail.com>
References: <20230906204857.85619-1-manmshuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6 Sep 2023, at 22:48, Manmohan Shukla wrote:

> This patch fixes a trivial markdown style nit in the `SAFETY` comment.
>
> Signed-off-by: Manmohan Shukla <manmshuk@gmail.com>
> ---

Reviewed-by: Finn Behrens <me@kloenk.dev>
