Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E227CB245
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjJPSWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbjJPSWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD371A7;
        Mon, 16 Oct 2023 11:22:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE96C433CA;
        Mon, 16 Oct 2023 18:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697480524;
        bh=5NxRmTuKS3MrtJS4PRD2pZQcXw9HDjeOVpmZjF91XA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UnZD9L1OrQX4ByQnZlyROGDZbNxaQb1IMwetseMkgFoC7w/va/MW99IC2m/Q8ZUez
         FGU43028NyZEqYllDcxq/moNaqYCKZYv3FH/QAnWEnp1CHCIWBu/oRw/We3ViEjdY6
         qKSN3+lwL/nXLwdbpIEnunlnK1zw4k9TWe60dqN4E1BMbfSRqfdwxdgm4RmeHczrwq
         cseM51k66FdNz97DWxxBNwRIAYYHE8aJowqXoOMLEL2HU+gfyY/nIR8I6vGWZxiZLL
         2ggLdrMwyuxJx01FCtJSMZupdA1GTztjLE/tG7yFcXplG50nbxuIzJcc3EUfqfw+6U
         VbHHdu0eqgcEQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] firmware: qcom: qseecom: add missing include guards
Date:   Mon, 16 Oct 2023 11:25:46 -0700
Message-ID: <169748074960.1245023.8311682400251418795.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004185732.98621-1-brgl@bgdev.pl>
References: <20231004185732.98621-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 04 Oct 2023 20:57:32 +0200, Bartosz Golaszewski wrote:
> The qseecom header does not contain ifdef guards against multiple
> inclusion. Add them.
> 
> 

Applied, thanks!

[1/1] firmware: qcom: qseecom: add missing include guards
      commit: ada1682d60ac6017037305166d02eb0cd5ee50fa

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
