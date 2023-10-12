Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDF57C7209
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347308AbjJLQGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbjJLQGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:06:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557A2CC;
        Thu, 12 Oct 2023 09:06:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7BAC433C7;
        Thu, 12 Oct 2023 16:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697126808;
        bh=00lPvPtzMCUPSLjIIa16o5rJLJHCDfj3pECK1utPSs0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=QJ0JlZ2L1r1KkhNHIRGx+Mo/3HN9OiCTVrlBNED3Gx+unODo3pKyMnlZmDZpp37OE
         fAifTI3MYzPpRSX4h9Q1Ql0Gzq5qX48qg+dRN5Jk3FO0Q4K9bEPXt2mpYAhmDHzuPz
         MlnYTjCPm8/CSKKIcK0Op/xcKmyX0+iMeGkdfEHDfzeSnIcLSRk3CLUWMXrNfchvaB
         bFlO+kNEa9EymKS6qJwMFdXyWRXK5ozx+6IhsHUnGWyEFcqski4xcy5fPDbwRrPX46
         ELsTwILTAq3/VmKPALalRabbNWfdFHh8S/K6cEK/lACi53Nt6gY4Ob9ZCyrmGLa8iz
         UvNbGznzHtXMw==
Date:   Thu, 12 Oct 2023 18:06:43 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        security@kernel.org, corbet@lwn.net, workflows@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Solar Designer <solar@openwall.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [RFC PATCH] Documentation: security-bugs.rst: linux-distros
 relaxed their rules
In-Reply-To: <20231007140454.25419-1-w@1wt.eu>
Message-ID: <nycvar.YFH.7.76.2310121805480.3534@cbobk.fhfr.pm>
References: <20231007140454.25419-1-w@1wt.eu>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Oct 2023, Willy Tarreau wrote:

> The linux-distros list relaxed their rules to try to adapt better to
> how the Linux kernel works. Let's update the Coordination part to
> explain why and when to contact them or not to and how to avoid trouble
> in the future.
> 
> Link: https://www.openwall.com/lists/oss-security/2023/09/08/4
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Solar Designer <solar@openwall.com>
> Cc: Vegard Nossum <vegard.nossum@oracle.com>
> Signed-off-by: Willy Tarreau <w@1wt.eu>

With my distro hat on:

	Acked-by: Jiri Kosina <jkosina@suse.cz>

Thanks a lot,

-- 
Jiri Kosina
SUSE Labs

