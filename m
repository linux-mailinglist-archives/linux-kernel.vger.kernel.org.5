Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82F87BBA37
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjJFO1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjJFO1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:27:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53F0A6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:27:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C56C433C7;
        Fri,  6 Oct 2023 14:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696602465;
        bh=lPsv0s+7IImsi8Hwkl8O4BUpaBHCF5fezH/OfMPtsag=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nf0gFn2olRoJvFSSwnp+Bv0BhFnfzFmQLU6WAU9cddtbmRQzFb0G7nl9EBGZD3ALW
         JoScSZI9M353+a3KWnG0rC4BMqQYs+RmSbxCHW6NzT7a6ZqGGSxBArqVqJGJ3Oi7Z3
         O9OnReyHTytvxFMc2chbPXpeyz7vqV/+jg3B/kiJI1KGLzFB/gap8kmGvvQS2G2RG2
         XW+jP+xIV/ltSxhypYrGt4zid0lJzCGOpsRWvQ7TPuT5ua/yUiNDID3fvzcjJT7M8c
         ZCokrvWUZq4ThyXRRhXPYJniFkHWq6BkH8YaTziPjC3YgWe63kr631rTxEaukRlxGm
         eDB6ePFtzOY4w==
Date:   Fri, 6 Oct 2023 07:27:44 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ayush Sawal <ayush.sawal@chelsio.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Raju Rangoju <Raju.Rangoju@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-hardening@vger.kernel.org, sourabh.sagar@chelsio.com,
        bharat@chelsio.com
Subject: Re: [PATCH 0/5] chelsio: Annotate structs with __counted_by
Message-ID: <20231006072744.66a1b412@kernel.org>
In-Reply-To: <6a750af0-1de2-3bec-3d52-a4007f3afe92@chelsio.com>
References: <20230929181042.work.990-kees@kernel.org>
        <202309291240.BC52203CB@keescook>
        <20231002113148.2d6f578b@kernel.org>
        <6a750af0-1de2-3bec-3d52-a4007f3afe92@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2023 01:58:54 +0530 Ayush Sawal wrote:
>  =C2=A0The current maintainer for cxgb4 driver is Sourabh Sagar=20
> <sourabh.sagar@chelsio.com>, I have added him in the CC.
>  =C2=A0He will update the MAINTAINERS file for cxgb4 driver.

Thanks & looking forward to the update!
