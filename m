Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482D87A0A62
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241904AbjINQHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241804AbjINQHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:07:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556CF1FF0;
        Thu, 14 Sep 2023 09:07:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EE2C433CB;
        Thu, 14 Sep 2023 16:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694707630;
        bh=ehQkWHJBuPju+u+N0FVzD7yR614q+6YZ5daHqnVOHdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVfx31tDhqLl9wzmHkAmCgxBZSbpCl5YH7OypZeHWd42YZ+rEJL6rGrMDNRFagB+R
         ZIEnFZdvo/nLfLwgr2Kq8iRcBM9VHRwlAqC1XbPi9G5wl7UZQcjK8fgnBxjG6e333r
         R5cw62WTXsnlKkJxEmZo+qd7tA+mLjyLKKjtwatXzZ8aVM0k4j5meNuhWtyXsfqFts
         tWQF94JT4aCu0E2YqDc55eWYzbmywaqCNGevLstUdQQC/H0wooAPPyIs6pIYG7oC3n
         fdh8+jK6pFbfZ6tizguXSJfT85VzScMXQ5upVNUfz4jZQRJnOIVt1DjB928JzE3AcH
         PelZRzJix0TRA==
Date:   Thu, 14 Sep 2023 09:11:14 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 08/17] pmdomain: qcom: Move Kconfig options to the
 pmdomain subsystem
Message-ID: <4ee5uio5nr467dpljhvzlzrpa4fcdds646dzmm5w2dqgjhyrnb@37d6e2f43vwq>
References: <20230914111753.586627-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914111753.586627-1-ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 01:17:53PM +0200, Ulf Hansson wrote:
> The Kconfig options belongs closer to the corresponding implementations,
> hence let's move them from the soc subsystem to the pmdomain subsystem.
> 
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: <linux-arm-msm@vger.kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn
