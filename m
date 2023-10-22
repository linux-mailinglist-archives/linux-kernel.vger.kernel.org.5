Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893027D22D8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 13:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjJVLTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 07:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjJVLTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 07:19:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D647E9
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 04:19:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B50FC433C7;
        Sun, 22 Oct 2023 11:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697973549;
        bh=EXt8EcTFEazDq8eq1sKNYxzGnzJ+KnJFV+nIJv+Njoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p2acUzWshbqhEQ7/ciMiGIRqt0h5Iyc0mPC6SBCVBND72JFnFKmPLFLIG4oRu4ds0
         VAv1bH89ywDR2x4ITHg1MYtPlYl3cMWZUAwwbZ93xjOuHfop3b7RqxdduEvVJSTAOa
         9B0J1gksT+pcQlQSZMXInTQLSFMHtiaVp/qp5o+o=
Date:   Sun, 22 Oct 2023 13:19:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumaran.4353@gmail.com
Subject: Re: [PATCH 2/3] staging: greybus: Alignment should match open
 parenthesis
Message-ID: <2023102241-unloader-finalize-c3c5@gregkh>
References: <cover.1697969950.git.nandhakumar.singaram@gmail.com>
 <57d7aa177d58384bcc178f6722a8f7f6af78a536.1697969950.git.nandhakumar.singaram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57d7aa177d58384bcc178f6722a8f7f6af78a536.1697969950.git.nandhakumar.singaram@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2023 at 03:40:57AM -0700, Nandha Kumar Singaram wrote:
> Adhere to linux coding style. Reported by checkpatch.pl:
> CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
> ---
>  drivers/staging/greybus/camera.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Same subject line problem :(

