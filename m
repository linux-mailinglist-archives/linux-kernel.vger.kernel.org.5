Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6D97C99F9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 18:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjJOQT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 12:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOQTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 12:19:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B517BA3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 09:19:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014F1C433C8;
        Sun, 15 Oct 2023 16:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697386763;
        bh=Foq+ZKV/up+n3+BeC7Sr70gK9IRTMkWGt417DsVXgbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IE+5KY8AC8FjKBp/hRikyXzLu+jQ3HKQG/7I+14CBEOpcg/cjz1/Af+KB1G0o/5+q
         TqaOaks8xETWyTVzMfkUVoAVVRG0IFC4XI4vYGLv08XLUdfssPc0IeuCRrUEgpP6bG
         q2b3q9xBVWBpNkZbMACidwbWRSWrbiTRC9+CjYQE=
Date:   Sun, 15 Oct 2023 18:19:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        ruanjinjie@huawei.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Remove unnecessary bracks
Message-ID: <2023101548-catalyze-employed-a617@gregkh>
References: <20231013002944.14607-1-edson.drosdeck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013002944.14607-1-edson.drosdeck@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 09:29:44PM -0300, Edson Juliano Drosdeck wrote:
> Warning found by checkpatch.pl script.Remove bracks than are not necessary for
> a single statement blocks in hal/odm.c

"bracks"?  I think it is called "brackets", right?

thanks,

greg k-h
