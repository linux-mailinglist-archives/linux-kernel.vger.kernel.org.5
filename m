Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D374B7C9A8A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 20:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjJOSFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 14:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJOSFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 14:05:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045EFAB;
        Sun, 15 Oct 2023 11:05:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3A1C433C8;
        Sun, 15 Oct 2023 18:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697393139;
        bh=HpTssnw808tqyXU+S4wRgjbl0jPobHnxdkz7GjEtVrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B1rfmrKADKsgDbhInnYFLX7527o+RDe3hlzlDMGg50D+gkhPtzUuIHt1ZJjDe1oh6
         epthc8AeC7U6Gdms7Eg0wWUvZFlrU2UjyUpujqY8OJ1n7YNcwfLc7vo5DZBUVsM1bv
         FRnA8pjkUTQ7Rv43POvIvmckURug/xAMuB6S2/oI=
Date:   Sun, 15 Oct 2023 20:05:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hongyu Xie <xy521521@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>, stable@kernel.org,
        Hongyu Xie <xiehongyu1@kylinos.cn>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [v2] xhci: Keep interrupt disabled in initialization until host
 is running.
Message-ID: <2023101524-subzero-trance-587d@gregkh>
References: <1697177797-18070-1-git-send-email-quic_prashk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697177797-18070-1-git-send-email-quic_prashk@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 11:46:37AM +0530, Prashanth K wrote:
> From: Hongyu Xie <xy521521@gmail.com>
> 
> [ Upstream commit a808925075fb750804a60ff0710614466c396db4 ]
> 

Now queued up, thanks.

greg k-h
