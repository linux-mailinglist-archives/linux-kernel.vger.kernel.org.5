Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCCE7BC70D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 13:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343871AbjJGLU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 07:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343812AbjJGLU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 07:20:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE34CB6;
        Sat,  7 Oct 2023 04:20:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8EAC433C8;
        Sat,  7 Oct 2023 11:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696677624;
        bh=Goru+Y5pM62Bn1EeWJzqWekpTQbwFCJNQZgYQQ0SQNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hSrDEXQwDwf8oKRRHiluOYocUBf8moy3ZQB1+xGnHCoXic/X5D3AP5g/MEmzYlYFm
         aAztTn4ZGnw15r/c1FYE6avriDZRcZOunqg3X4/ayJeAUlu166/M/FT/GKpcMBEnp/
         F0LH8Du2ie1cgCZYXjY7uYOxHPj+M7gIG+qd2//E=
Date:   Sat, 7 Oct 2023 13:20:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, Hongyu Xie <xy521521@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>, stable@kernel.org,
        Hongyu Xie <xiehongyu1@kylinos.cn>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        "# 5 . 15" <stable@vger.kernel.org>
Subject: Re: [PATCH RESEND] xhci: Keep interrupt disabled in initialization
 until host is running.
Message-ID: <2023100753-jargon-resolute-0e55@gregkh>
References: <1695379724-28628-1-git-send-email-quic_prashk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695379724-28628-1-git-send-email-quic_prashk@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 04:18:44PM +0530, Prashanth K wrote:
> From: Hongyu Xie <xy521521@gmail.com>
> 
> [ Upstream commit 808925075fb750804a60ff0710614466c396db4 ]

This is not a valid git commit id in Linus's tree, where is it from?

confused,

greg k-h
